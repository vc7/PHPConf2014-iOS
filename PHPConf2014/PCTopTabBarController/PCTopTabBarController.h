//
//  PCTopTabBarController.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/05.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PCTopTabBar.h"
#import "PCTopTabBarItem.h"

@protocol PCTopTabBarControllerDelegate;

@interface PCTopTabBarController : UIViewController

@property (nonatomic, weak) id<PCTopTabBarControllerDelegate> delegate;
@property (nonatomic, readonly) PCTopTabBar *tabBar;

@property (nonatomic, strong) NSArray *viewControllers;

@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, weak) UIViewController *selectedViewController;

@end

@protocol PCTopTabBarControllerDelegate <NSObject>

@optional

- (void)tabBarController:(PCTopTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@interface UIViewController (PCTopTabBarControllerItem)

@property (nonatomic, strong) PCTopTabBarItem *topTabBarItem;

@end