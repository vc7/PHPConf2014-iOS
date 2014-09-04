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

#import "UIColor+PHPConfAdditions.h"

@implementation PCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [PCKit setApplicationId:kPCApplicationID
                   dataSpec:[[PCDataSpecDefines alloc] init]];
    
    [self applyStyleSheet];
    
    [self.window makeKeyAndVisible];
    return YES;
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
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName:[UIColor whiteColor] };
    
    [UITabBar appearance].tintColor = [UIColor phpconfBlueColor];
}

@end
