//
//  PCTopTabBarItem.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/06.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCTopTabBarItem : UIButton

@property (nonatomic, strong) UIColor *indicatorColor;

- (instancetype)initWithTitle:(NSString *)title tag:(NSInteger)tag;

@end
