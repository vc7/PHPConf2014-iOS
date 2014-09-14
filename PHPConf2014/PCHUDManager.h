//
//  PCHUDManager.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/14.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;

@interface PCHUDManager : NSObject

@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong, readonly) MBProgressHUD *progressHUD;

/*! The default manager.
 @discussion The HUD that is managed by the default manager is set to lay onto the main window's root view controller, covered on the whole screen by default.
 @return the shared instance of default manager.
 */
+ (instancetype)defaultManager;

/*! Create a custom manager by giving a parent view
 @param parentView the givin view are going to add HUD on.
 @return the instance of a custom manager.
 */
- (instancetype)initWithParentView:(UIView *)parentView;

/*! The most easy way to pop the managed HUD view out */
- (void)showHUD;
/*! The most easy way to dismiss the managed HUD view */
- (void)hideHUD;

@end
