//
//  PCInfoListsViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/04.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCInfoListsViewController.h"

@interface PCInfoListsViewController ()

@end

@implementation PCInfoListsViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"關於";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIViewController *viewControllerA = [[UIViewController alloc] init];
    viewControllerA.title = @"PHPConf";
    
    UIViewController *viewControllerB = [[UIViewController alloc] init];
    viewControllerB.title = @"贊助商";

    UIViewController *viewControllerC = [[UIViewController alloc] init];
    viewControllerC.title = @"App";
    
    self.viewControllers = @[viewControllerA, viewControllerB, viewControllerC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
