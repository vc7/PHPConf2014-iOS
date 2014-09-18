//
//  PCVenueMapsViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/04.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCVenueMapsViewController.h"

@interface PCVenueMapsViewController ()

@end

@implementation PCVenueMapsViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"地圖";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIViewController *viewControllerA = [[UIViewController alloc] init];
    viewControllerA.title = @"會場地圖";
    
    UIViewController *viewControllerB = [[UIViewController alloc] init];
    viewControllerB.title = @"輔大地圖";
    
    self.viewControllers = @[viewControllerA, viewControllerB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
