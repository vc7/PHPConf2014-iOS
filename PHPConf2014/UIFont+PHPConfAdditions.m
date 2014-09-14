//
//  UIFont+PHPConfAdditions.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/14.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "UIFont+PHPConfAdditions.h"

@implementation UIFont (PHPConfAdditions)

+ (UIFont *)phpconfFontSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"NotoSansCJKtc-DemiLight" size:fontSize];
}

+ (UIFont *)phpconfBoldFontSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"NotoSansCJKtc-Bold" size:fontSize];
}

@end
