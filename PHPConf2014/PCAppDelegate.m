//
//  PCAppDelegate.m
//  PHPConf2014
//
//  Created by vincent on 2014/08/25.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCAppDelegate.h"
#import "PCDefines.h"
#import "PCDataSpecDefines.h"

#import "PCSessionListsViewController.h"
#import "PCVenueMapsViewController.h"
#import "PCNewsListViewController.h"
#import "PCInfoListsViewController.h"

#import "PCVenueMapMainViewController.h"

#import "Venue.h"
#import "Version.h"
#import "Session.h"
#import "SponsorType.h"
#import "Department.h"

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"
#import "PCHUDManager.h"

#import <MBProgressHUD/MBProgressHUD.h>

typedef void (^PCCompletionBlock)(BOOL success, NSError *error);

@interface PCAppDelegate ()

@property (nonatomic, strong) PCHUDManager *HUDManager;
@property (nonatomic) NSInteger processingQueueCount;

@end

@implementation PCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = self.mainTabBarController;
    
    [self applyStyleSheet];
    [self applyServices];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self checkAndUpdateVersion];
}

#pragma mark - Shared Instance

+ (PCAppDelegate *)sharedAppDelegate
{
    return (PCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - Style

- (void)applyStyleSheet
{
    // Add settings into the plist to make status text white
    // 1) UIViewControllerBasedStatusBarAppearance -> NO
    // 2) UIStatusBarStyle -> UIStatusBarStyleBlackOpaque
    
    // UINavigationBar's background color
    [UINavigationBar appearance].barTintColor = [UIColor phpconfBlueColor];
    [UINavigationBar appearance].barStyle = UIBarStyleBlackTranslucent;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName:[UIColor whiteColor],
                                                          NSFontAttributeName:[UIFont phpconfFontSize:16.f]};
    
    [UITabBar appearance].tintColor = [UIColor phpconfBlueColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont phpconfFontSize:9.f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -5.f)];
}

#pragma mark - Services

- (void)applyServices
{
    // Set the application id
    [PCKit setApplicationId:kPCApplicationID dataSpec:[PCDataSpecDefines new]];
    
    // Set Google Services API Key
    [GMSServices provideAPIKey:kPCGoogleApiKey];
}

#pragma mark - Accessors

- (UITabBarController *)mainTabBarController
{
    if (!_mainTabBarController) {
        _mainTabBarController = [[UITabBarController alloc] init];
        
        _mainTabBarController.viewControllers = @[
                                                  [[UINavigationController alloc] initWithRootViewController:[[PCSessionListsViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[PCVenueMapsViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[PCNewsListViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[PCInfoListsViewController alloc] init]]
                                                  ];
    }
    
    return _mainTabBarController;
}

- (PCHUDManager *)HUDManager
{
    if (!_HUDManager) {
        _HUDManager = [PCHUDManager defaultManager];
    }
    return _HUDManager;
}

#pragma mark - Check Version

- (void)checkAndUpdateVersion
{
    self.processingQueueCount = 0;
    self.HUDManager.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.HUDManager.progressHUD.labelText = @"檢查本地資料中～";
    [self.HUDManager showHUD];
    
    [self processingQueueCountPlus:YES];
    
    [[PCKSynchronizer sharedSynchronizer] checkRemoteDataVersionWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        Version *version = [Version MR_findFirstInContext:context];
        BOOL shouldUpdate = YES;
        
        if (!version) {
            version = [Version MR_createEntity];
            version.name = responseObject[@"name"];
            version.code = responseObject[@"code"];
            version.createdAt = [NSDate date];
            version.updatedAt = [NSDate date];
        } else {
            if ([version.code isEqualToNumber:responseObject[@"code"]]) {
                DLog(@"Data is already up to date with version: %@", version.name);
                shouldUpdate = NO;
            } else {
                version.name = responseObject[@"name"];
                version.code = responseObject[@"code"];
                version.updatedAt = [NSDate date];
            }
        }
        
        [self processingQueueCountPlus:NO];
        
        if (!shouldUpdate) {
            [self processingQueueCountPlus:YES]; // update version
            [context MR_saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
                [self processingQueueCountPlus:NO];
                if (success) {
                    DLog(@"success");
                    [self updateData];
                }
            }];
        } else {
            DLog(@"No need to update");
            
            [self removeHUDIfNeededWithMessage:@"目前已經是最新的資料囉！"];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@",[error localizedDescription]);
    }];
    
    [self updateData];

}

- (void)updateData
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    self.HUDManager.progressHUD.labelText = @"取得最新資料中";
    [self processingQueueCountPlus:YES];
    
    [self initializeDataIfNeeded];
    
    [self cleanDataWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            DLog(@"======= success =======");

            [self processingQueueCountPlus:NO]; // clean data end
            
            [self processingQueueCountPlus:YES]; // session request start
            
            [[PCKSynchronizer sharedSynchronizer] fetchSessionsWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                
                [self processingQueueCountPlus:NO]; // session request end
                
                for (NSInteger index = 0; index < 2; index++) {
                    DLog(@"session - %ld",(long)index);
                    
                    NSArray *sessionArray = responseObject[index];
                    
                    [sessionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSString *startTimeString = [NSString stringWithFormat:@"2014/10/18 %@:00", obj[@"gsx$start"][@"$t"]];
                        NSString *endTimeString = [NSString stringWithFormat:@"2014/10/18 %@:00", obj[@"gsx$end"][@"$t"]];
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
                        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Taipei"];
                        NSDate *startTimeDate = [dateFormatter dateFromString:startTimeString];
                        NSDate *endTimeDate = [dateFormatter dateFromString:endTimeString];
                        
                        // Save
                        Session *newSession = [Session MR_createInContext:context];
                        newSession.title = obj[@"gsx$title"][@"$t"];
                        newSession.detail = obj[@"gsx$detail"][@"$t"];
                        newSession.startedAt = startTimeDate;
                        newSession.endedAt = endTimeDate;
                        
                        [context MR_saveOnlySelfAndWait];
                        DLog(@"session - %@ has been saved", newSession);
                        //DLog(@"session - %d\n-----\ntitle:\n%@\n-----\ntime:\n%@ ~ %@\n-----\ndetail:\n%@\n-----\n",index, obj[@"gsx$title"][@"$t"], [dateFormatter stringFromDate:startTimeDate], [dateFormatter stringFromDate:endTimeDate], obj[@"gsx$detail"][@"$t"]);
                    }];
                    
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
            [[PCKSynchronizer sharedSynchronizer] fetchVenuesWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                DLog(@"venues - records count: %d",[responseObject count]);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
            [[PCKSynchronizer sharedSynchronizer] fetchSponsorsSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                DLog(@"sponsors - records count: %d",[responseObject count]);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
            [[PCKSynchronizer sharedSynchronizer] fetchConfInfoWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                DLog(@"conf info - records count: %d",[responseObject count]);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
            [self removeHUDIfNeededWithMessage:@"議程資料更新完成"];
        }
    }];
}

- (void)cleanDataWithCompletion:(PCCompletionBlock)completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __block NSException *excuteException = nil;
        __block NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        
        @try {
            
            NSArray *sessionsResult = [Session MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"title != nil && isRegular == %@", @YES] inContext:context];
            
            if ([sessionsResult count] > 0) {
                [Session MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"title != nil && isRegular == %@", @YES] inContext:context];
                [context MR_saveOnlySelfAndWait];
                NSArray *sessionNewResult = [Session MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"title != nil"] inContext:context];
                if (sessionNewResult.count == 0) {
                    DLog(@"Clean - session");
                }
            }
            
        }
        @catch (NSException *exception) {
            excuteException = exception;
        }
        @finally {
            if (excuteException) {
                DLog(@"Clean data with exception");
                completion(NO, [NSError errorWithDomain:@"PCCleanUpDataError" code:-1 userInfo:@{NSLocalizedDescriptionKey:[excuteException reason]}]);
            } else {
                DLog(@"Clean data without exception");
                completion(YES, nil);
            }
        }
    });
}

- (void)initializeDataIfNeeded
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    // Init Venues
    
    NSArray *venues = [Venue MR_findAllInContext:context];
    
    if (venues.count == 0) {
        Venue *venue01 = [Venue MR_createInContext:context];
        venue01.name = @"國璽樓一樓多功能國際會議廳";
        venue01.createdAt = [NSDate date];
        venue01.updatedAt = [NSDate date];
        
        Venue *venue02 = [Venue MR_createInContext:context];
        venue02.name = @"國璽樓二樓國際會議廳";
        venue02.createdAt = [NSDate date];
        venue02.updatedAt = [NSDate date];
        
        [context MR_saveToPersistentStoreAndWait];
        
        DLog(@"====================================");
        DLog(@"Init Data - Venues are Added");
        DLog(@"====================================");
    } else {
        DLog(@"====================================");
        DLog(@"Init Data - Venues are OK");
        DLog(@"====================================");
    }
    
    NSArray *newVenues = [Venue MR_findAllInContext:context];
    
    DLog(@"====================================");
    DLog(@"Init Data - Venues count: %ld", newVenues.count);
    DLog(@"====================================");
    
    venues = nil;
    newVenues = nil;
    
    // Init Venues - END
    
    // Init Type Other Sessions
    
    NSArray *sessions = [Session MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isRegular == %@", @NO] inContext:context];
    
    if (sessions.count == 0) {
        
        NSArray *otherSessions = @[
                                   @{@"startedAt":@"09:00",
                                     @"endedAt":@"09:20",
                                     @"title":@"報到"
                                     },
                                   @{@"startedAt":@"09:20",
                                     @"endedAt":@"09:30",
                                     @"title":@"開幕"
                                     },
                                   @{@"startedAt":@"10:40",
                                     @"endedAt":@"10:50",
                                     @"title":@"休息"
                                     },
                                   @{@"startedAt":@"11:30",
                                     @"endedAt":@"12:30",
                                     @"title":@"午餐"
                                     },
                                   @{@"startedAt":@"13:20",
                                     @"endedAt":@"13:30",
                                     @"title":@"休息"
                                     },
                                   @{@"startedAt":@"14:10",
                                     @"endedAt":@"14:40",
                                     @"title":@"下午茶"
                                     },
                                   @{@"startedAt":@"15:10",
                                     @"endedAt":@"15:20",
                                     @"title":@"休息"
                                     },
                                   @{@"startedAt":@"16:00",
                                     @"endedAt":@"16:10",
                                     @"title":@"休息"
                                     },
                                   @{@"startedAt":@"16:50",
                                     @"endedAt":@"17:00",
                                     @"title":@"閉幕"
                                     },
                                   ];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Taipei"];
        
        [otherSessions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSString *startTimeString = [NSString stringWithFormat:@"2014/10/18 %@:00", obj[@"startedAt"]];
            NSString *endTimeString = [NSString stringWithFormat:@"2014/10/18 %@:00", obj[@"endedAt"]];
            
            NSDate *startTimeDate = [dateFormatter dateFromString:startTimeString];
            NSDate *endTimeDate = [dateFormatter dateFromString:endTimeString];
            
            Session *session = [Session MR_createInContext:context];
            
            session.isRegular = @NO;
            session.title = obj[@"title"];
            session.startedAt = startTimeDate;
            session.endedAt = endTimeDate;
            
        }];
        
        [context MR_saveToPersistentStoreAndWait];
        
        DLog(@"====================================");
        DLog(@"Init Data - Other Sessions are Added");
        DLog(@"====================================");
    } else {
        
        DLog(@"====================================");
        DLog(@"Init Data - Other Sessions are OK");
        DLog(@"====================================");
        
    }
    
    NSArray *newSessions = [Session MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"isRegular == %@", @NO] inContext:context];
    
    DLog(@"====================================");
    DLog(@"Init Data - Sessions count: %ld", newSessions.count);
    DLog(@"====================================");
    
    sessions = nil;
    newSessions = nil;
    
    // Init Type Other Sessions - END
    
    // Init Sponsor Types
    
    NSArray *sponsorTypes = [SponsorType MR_findAllInContext:context];
    
    if (sponsorTypes.count == 0) {
        
        SponsorType *type01 = [SponsorType MR_createInContext:context];
        type01.name = @"黃金級";
        type01.createdAt = [NSDate date];
        type01.updatedAt = [NSDate date];
        
        SponsorType *type02 = [SponsorType MR_createInContext:context];
        type02.name = @"鑽石級";
        type02.createdAt = [NSDate date];
        type02.updatedAt = [NSDate date];
        
        SponsorType *type03 = [SponsorType MR_createInContext:context];
        type03.name = @"特別感謝";
        type03.createdAt = [NSDate date];
        type03.updatedAt = [NSDate date];
        
        SponsorType *type04 = [SponsorType MR_createInContext:context];
        type04.name = @"合作媒體";
        type04.createdAt = [NSDate date];
        type04.updatedAt = [NSDate date];
        
        [context MR_saveToPersistentStoreAndWait];
        
        DLog(@"====================================");
        DLog(@"Init Data - Sponsor Types are Added");
        DLog(@"====================================");
    } else {
        DLog(@"====================================");
        DLog(@"Init Data - Sponsor Types are OK");
        DLog(@"====================================");
    }
    
    NSArray *newSponsorTypes = [SponsorType MR_findAllInContext:context];
    
    DLog(@"====================================");
    DLog(@"Init Data - Sponsor types count: %ld", newSponsorTypes.count);
    DLog(@"====================================");
    
    sponsorTypes = nil;
    newSponsorTypes = nil;
    
    // Init Sponsor Types - END
    
    // Init Staff Deparments
    
    NSArray *departments = [Department MR_findAllInContext:context];
    
    if (departments.count == 0) {
        
        NSArray *departmentNames = @[@"總召", @"議程", @"場務", @"採購", @"行政", @"票務", @"贊助", @"公關", @"設計", @"法律顧問", @"記錄線路", @"App 製作", @"網站製作"];
        
        [departmentNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Department *department = [Department MR_createInContext:context];
            department.name = obj;
            department.createdAt = [NSDate date];
            department.updatedAt = [NSDate date];
            
            [context MR_saveToPersistentStoreAndWait];
        }];
        
        DLog(@"====================================");
        DLog(@"Init Data - Departments are Added");
        DLog(@"====================================");
    } else {
        DLog(@"====================================");
        DLog(@"Init Data - Departments are OK");
        DLog(@"====================================");
    }
    
    NSArray *newDepartments = [Department MR_findAllInContext:context];
    
    DLog(@"====================================");
    DLog(@"Init Data - Departments count: %ld", newDepartments.count);
    DLog(@"====================================");
    
    departments = nil;
    newDepartments = nil;
    
    
}

- (void)removeHUDIfNeededWithMessage:(NSString *)message
{
    if (self.processingQueueCount == 0) {
        sleep(2.0f);
        self.HUDManager.progressHUD.mode = MBProgressHUDModeText;
        self.HUDManager.progressHUD.labelText = message;
        [self.HUDManager.progressHUD hide:YES afterDelay:2.0f];
    } else {
        DLog(@"There still have %ld process(es)", self.processingQueueCount);
    }
}

- (void)processingQueueCountPlus:(BOOL)isPlus
{
    if (isPlus) {
        self.processingQueueCount ++;
    } else {
        self.processingQueueCount --;
        [self removeHUDIfNeededWithMessage:@"議程資料更新完成"];
    }
    
    DLog(@"Processing Queue Count: %ld", (long)self.processingQueueCount);
}

@end
