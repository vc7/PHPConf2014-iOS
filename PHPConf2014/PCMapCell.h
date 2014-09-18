//
//  PCMapCell.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/15.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCMapCell : UITableViewCell

@property (nonatomic) CLLocationCoordinate2D *location;

- (void)initializeMapViewIfNeeded;

@end
