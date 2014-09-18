//
//  PCNewsCell.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/14.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCNewsCell.h"

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"

@interface PCNewsCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITextView *titleTextView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *publishLabel;

@property (nonatomic, strong) CALayer *foregroundLayer;

@end

@implementation PCNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self applyStyleSheet];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.containerView.frame = (CGRect){{8, 8}, {CGRectGetWidth(self.frame) - 8 * 2, CGRectGetHeight(self.frame)}};
    self.foregroundLayer.frame = (CGRect){{1, 1}, {CGRectGetWidth(self.containerView.frame) - 1 * 2, CGRectGetHeight(self.containerView.frame) - 1 * 2}};
    
    self.titleTextView.frame = (CGRect){{15, 15}, {CGRectGetWidth(self.frame) - 15 * 2 , 30.f}};
    self.publishLabel.frame = (CGRect){{20.5, CGRectGetMaxY(self.titleTextView.frame)}, {CGRectGetWidth(self.frame) - 20.5 * 2 , 15.f}};
    self.contentTextView.frame = (CGRect){{15, CGRectGetMaxY(self.publishLabel.frame) + 5}, {CGRectGetWidth(self.frame) - 15 * 2 , 100}};
    
    [self bringSubviewToFront:self.titleTextView];
    [self bringSubviewToFront:self.publishLabel];
    [self bringSubviewToFront:self.contentTextView];
}

#pragma mark - Accessors

- (void)setNewsContent:(NSString *)newsContent
{
    if (![_newsContent isEqualToString:newsContent]) {
        _newsContent = newsContent;
        
        self.contentTextView.text = newsContent;
        
        [self setNeedsLayout];
    }
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectZero];
        _containerView.layer.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1].CGColor;
        _containerView.layer.cornerRadius = 2.f;
        _containerView.layer.masksToBounds = YES;
        
        [self addSubview:_containerView];
    }
    
    return _containerView;
}

- (UITextView *)titleTextView
{
    if (!_titleTextView) {
        _titleTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _titleTextView.editable = NO;
        _titleTextView.text = @"Default Title";
        [self addSubview:_titleTextView];
    }
    return _titleTextView;
}

- (UILabel *)publishLabel
{
    if (!_publishLabel) {
        _publishLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _publishLabel.text = @"Publish time not been set.";
        [self addSubview:_publishLabel];
    }
    return _publishLabel;
}

- (UITextView *)contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _contentTextView.editable = NO;
        [self addSubview:_contentTextView];
    }
    
    return _contentTextView;
}

- (CALayer *)foregroundLayer
{
    if (!_foregroundLayer) {
        _foregroundLayer = [[CALayer alloc] init];
        _foregroundLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _foregroundLayer.cornerRadius = 1.f;
        _foregroundLayer.masksToBounds = YES;
        
        [self.containerView.layer addSublayer:_foregroundLayer];
    }
    return _foregroundLayer;
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    self.backgroundColor = [UIColor clearColor];
    
    self.titleTextView.font = [UIFont phpconfBoldFontSize:14.f];
    self.titleTextView.textColor = [UIColor phpconfGrayColor];
    self.titleTextView.backgroundColor = [UIColor clearColor];
    self.titleTextView.scrollEnabled = NO;
    
    self.publishLabel.font = [UIFont phpconfFontSize:9.f];
    self.publishLabel.textColor = [UIColor lightGrayColor];
    self.publishLabel.backgroundColor = [UIColor clearColor];
    
    self.contentTextView.font = [UIFont phpconfFontSize:13.f];
    self.contentTextView.textColor = [UIColor phpconfBlackColor];
    self.contentTextView.backgroundColor = [UIColor clearColor];
    self.contentTextView.scrollEnabled = NO;
}

@end
