//
//  PCNewsCell.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/14.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCNewsCell : UITableViewCell

@property (nonatomic, strong) NSDate *publishAt;
@property (nonatomic, strong) NSString *newsContent;

@end
