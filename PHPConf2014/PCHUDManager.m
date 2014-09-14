//
//  PCHUDManager.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/14.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCHUDManager.h"
#import "PCAppDelegate.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface PCHUDManager ()

@property (nonatomic, strong, readwrite) MBProgressHUD *progressHUD;

@end

@implementation PCHUDManager

#pragma mark - Singleton

+ (instancetype)defaultManager {
    static dispatch_once_t pred;
    static PCHUDManager *shared = nil;
    dispatch_once(&pred, ^{
        
        UIView *parentView = ((PCAppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController.view;
        
        shared = [[PCHUDManager alloc] initWithParentView:parentView];

    });
    return shared;
}

#pragma mark - Life Cycle

- (instancetype)initWithParentView:(UIView *)parentView
{
    self = [super init];
    if (self) {
        self.parentView = parentView;
    }
    return self;
}

- (void)dealloc
{
    [self.progressHUD removeFromSuperview];
}

#pragma mark - Accessors

- (MBProgressHUD *)progressHUD
{
    NSAssert(self.parentView, @"Set a parent view before using progressHUD.");
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.parentView];
        [self.parentView addSubview:_progressHUD];
    }
    
    return _progressHUD;
}

#pragma mark - Public Methods

- (void)showHUD
{
    [self.progressHUD show:YES];
}

- (void)hideHUD
{
    [self.progressHUD hide:YES];
}

@end
