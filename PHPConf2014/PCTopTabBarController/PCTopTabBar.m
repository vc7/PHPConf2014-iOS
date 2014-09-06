//
//  PCTopTabBar.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/06.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCTopTabBar.h"

@implementation PCTopTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - UIView - UIViewHierarchy

- (void)layoutSubviews
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - Accessors

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // remove item subviews
    // add new item subviews
}

@end
