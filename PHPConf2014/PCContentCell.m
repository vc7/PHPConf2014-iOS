//
//  PCContentCell.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/15.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCContentCell.h"

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"

@implementation PCContentCell

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
}

#pragma mark - Private Methods

- (void)applyStyleSheet
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont phpconfFontSize:14.f];
    self.textLabel.textColor = [UIColor phpconfBlackColor];
    self.textLabel.numberOfLines = 0;
}

@end
