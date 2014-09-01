//
//  UIColor+PHPConfAdditions.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "UIColor+PHPConfAdditions.h"

@implementation UIColor (PHPConfAdditions)

+ (UIColor *)phpconfBlackColor
{
    return [self colorWithWhite:0.8 alpha:1];
}
+ (UIColor *)phpconfGrayColor
{
    return [self colorWithWhite:0.4 alpha:1];
}
+ (UIColor *)phpconfYellowColor
{
    return [self colorWithRed:223/255.f green:223/255.f blue:111/255.f alpha:1];
}
+ (UIColor *)phpconfGreenColor
{
    return [self colorWithRed:0/255.f green:169/255.f blue:151/255.f alpha:1];
}

+ (UIColor *)phpconfBlueColor
{
    return [self colorWithRed:63/255.f green:152/255.f blue:204/255.f alpha:1];
}
+ (UIColor *)phpconfDarkBlueColor
{
    return [self colorWithRed:20/255.f green:98/255.f blue:144/255.f alpha:1];
}
+ (UIColor *)phpconfLightBlueColor
{
    return [self colorWithRed:187/255.f green:217/255.f blue:240/255.f alpha:1];
}
+ (UIColor *)phpconfExtraLightBlueColor
{
    return [self colorWithRed:246/255.f green:252/255.f blue:254/255.f alpha:1];
}

@end
