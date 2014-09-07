//
//  PCTopTabBar.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/06.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCTopTabBarItem;

@protocol PCTopTabBarDelegate;

@interface PCTopTabBar : UIView

@property (nonatomic, weak) id<PCTopTabBarDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) PCTopTabBarItem *selectedItem;

@end

@protocol PCTopTabBarDelegate <NSObject>

@optional

- (void)tabBar:(PCTopTabBar *)tabBar didSelectItem:(PCTopTabBarItem *)item;

@end
