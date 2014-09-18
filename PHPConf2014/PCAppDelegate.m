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

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"

@interface PCAppDelegate ()

@end

@implementation PCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = self.mainTabBarController;
    
    [self applyStyleSheet];
    [self applyServices];

    [[PCKSynchronizer sharedSynchronizer] checkRemoteDataVersionWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        DLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.window makeKeyAndVisible];
    
    return YES;
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
                                                  [[UINavigationController alloc] initWithRootViewController:[[PCVenueMapMainViewController alloc] init]],
                                                  //[[UINavigationController alloc] initWithRootViewController:[[PCNewsListViewController alloc] init]],
                                                  [[UINavigationController alloc] initWithRootViewController:[[PCInfoListsViewController alloc] init]]
                                                  ];
    }
    
    return _mainTabBarController;
}

@end
