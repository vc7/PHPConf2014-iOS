//
//  UILabel+hieght.h
//  PHPConf2014
//
//  Created by vincent on 2014/10/10.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (height)

+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;

@end
