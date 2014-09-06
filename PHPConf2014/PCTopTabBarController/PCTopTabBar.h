//
//  PCTopTabBar.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/06.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCTopTabBarItem;

@interface PCTopTabBar : UIView

@property (nonatomic, strong) NSArray *items;

@end

@protocol PCTopTabBarDelegate <NSObject>

@optional

- (void)tabBar:(PCTopTabBar *)tabBar didSelectItem:(PCTopTabBarItem *)item;

@end
