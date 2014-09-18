//
//  PCSecondaryTitleCell.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/15.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCSecondaryTitleCell.h"

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"

@interface PCSecondaryTitleCell ()

@property (nonatomic, strong) CALayer *underline;

@end

@implementation PCSecondaryTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self applyStyleSheet];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat underlineWidth = 1;
    self.underline.frame = (CGRect){{CGRectGetMinX(self.textLabel.frame), CGRectGetHeight(self.frame) - underlineWidth}, {CGRectGetWidth(self.textLabel.frame), underlineWidth}};
}

#pragma mark - Accessors

- (CALayer *)underline
{
    if (!_underline) {
        _underline = [[CALayer alloc] init];
        _underline.backgroundColor = [UIColor phpconfGreenColor].CGColor;
        
        [self.layer addSublayer:_underline];
    }
    
    return _underline;
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor phpconfGrayColor];
    self.textLabel.font = [UIFont phpconfBoldFontSize:13.f];
}

@end
