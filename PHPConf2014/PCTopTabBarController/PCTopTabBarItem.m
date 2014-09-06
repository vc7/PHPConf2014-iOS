//
//  PCTopTabBarItem.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/06.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCTopTabBarItem.h"

@implementation PCTopTabBarItem

- (instancetype)initWithTitle:(NSString *)title tag:(NSInteger)tag
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.frame = CGRectZero;
        self.tag = tag;
        
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - UIView - UIViewHierachy

- (void)layoutSubviews
{
    self.titleLabel.center = self.center;
}

@end
