//
//  PCSessionCell.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/09.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! Define the states of the cell. */
typedef NS_ENUM(NSInteger, PCSessionCellState) {
    PCSessionCellStateDefault,  // will show top and bottom stick
    PCSessionCellStateFirst,    // will not show the top stick
    PCSessionCellStateLast      // will not show the bottom stick
};

@interface PCSessionCell : UITableViewCell

/*! Set the cell's state, default is PCSessionCellStateDefault */
@property (nonatomic) PCSessionCellState cellState;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@interface PCSessionRegularCell : PCSessionCell

@property (nonatomic, strong) UIImage *avatarImage;

@end

@interface PCSessionOtherCell : PCSessionCell

@end