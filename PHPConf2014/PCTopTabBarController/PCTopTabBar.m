//
//  PCTopTabBar.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/06.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCTopTabBar.h"
#import "PCTopTabBarItem.h"

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
    [super layoutSubviews];
    
    if (self.items.count > 0) {
        
        __block CGFloat height = CGRectGetHeight(self.frame);
        __block CGFloat unitWidth = CGRectGetWidth(self.frame) / self.items.count;
        
        [self.items enumerateObjectsUsingBlock:^(PCTopTabBarItem *item, NSUInteger index, BOOL *stop) {
            item.frame = (CGRect){ unitWidth * index, 0, unitWidth, height};
        }];
    }
}

#pragma mark - Accessors

- (void)setItems:(NSArray *)items
{
    _items = items;

    [self removeChildviews];
    [self addChildviewsWithItems:_items];
    
}

- (void)setSelectedItem:(PCTopTabBarItem *)selectedItem
{
    if (_selectedItem != selectedItem) {
        _selectedItem = selectedItem;
        _selectedItem.selected = YES;
        
        [self.items enumerateObjectsUsingBlock:^(PCTopTabBarItem *item, NSUInteger idx, BOOL *stop) {
            if (item != _selectedItem) {
                item.selected = NO;
            }
        }];
    }
}

#pragma mark - Button Selectors

- (void)itemClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.delegate tabBar:self didSelectItem:sender];
    }
}

#pragma mark - Private Methods

- (void)removeChildviews
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[PCTopTabBarItem class]]) {
            [obj removeFromSuperview];
        }
    }];
}

- (void)addChildviewsWithItems:(NSArray *)items
{
    [items enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        [self bringSubviewToFront:item];
    }];
}

@end
