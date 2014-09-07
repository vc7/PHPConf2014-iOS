//
//  PCTopTabBarItem.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/06.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCTopTabBarItem.h"
#import "UIColor+PHPConfAdditions.h"

@interface PCTopTabBarItem ()

@property (nonatomic, strong) CALayer *indicatorRect;

@end

@implementation PCTopTabBarItem

- (instancetype)initWithTitle:(NSString *)title tag:(NSInteger)tag
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.tag = tag;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [self setTitle:title forState:UIControlStateNormal];
        
        self.indicatorColor = [UIColor phpconfYellowColor];
        self.indicatorRect = [[CALayer alloc] init];
        self.indicatorRect.backgroundColor = self.indicatorColor.CGColor;
        
        [self.layer addSublayer:self.indicatorRect];
        
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    return self;
}

#pragma mark - UIView - UIViewHierachy

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Accessors

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.indicatorRect.frame = (CGRect){ 0, CGRectGetHeight(self.frame) - 2, CGRectGetWidth(self.frame), 2};
    
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    self.indicatorRect.hidden = !selected;
    [super setSelected:selected];
}

@end
