//
//  UILabel+hieght.m
//  PHPConf2014
//
//  Created by vincent on 2014/10/10.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "UILabel+height.h"

@implementation UILabel (height)

+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize+4;
    CGFloat width = widthValue;
    if (text) {
        CGSize textSize = { width, CGFLOAT_MAX };       //Width and height of text area
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        CGSize size = CGSizeMake(frame.size.width, frame.size.height+1);
        
        result = MAX(size.height, result); //At least one row
    }
    return result;
}

@end
