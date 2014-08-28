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

@implementation PCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [PCKit setApplicationId:kPCApplicationID
                   dataSpec:[[PCDataSpecDefines alloc] init]];
    
    NSLog(@"%@", [PCKit getApplicationId]);
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
