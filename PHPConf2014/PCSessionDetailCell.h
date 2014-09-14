//
//  PCSessionDetailCell.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/13.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class PCSessionDetailCell
 The base class that is going to use in the session detail view.
 */
@interface PCSessionDetailCell : UITableViewCell

@end

/*!
 @class PCSessionDetailHeroCell
 The cell class to display the top banner, speaker's name and position.
 */
@interface PCSessionDetailHeroCell : PCSessionDetailCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) NSString *speakerName;
@property (nonatomic, strong) NSString *speakerPosition;
@property (nonatomic, strong) NSString *venueName;

@end

/*!
 @class PCSessionDetailIntroCell
 The cell class that display the title of the session.
 */
@interface PCSessionDetailIntroCell : PCSessionDetailCell

@end