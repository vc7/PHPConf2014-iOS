//
//  PCSessionListsViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/04.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCSessionListsViewController.h"
#import "PCSessionTableViewController.h"
#import "PCSessionDetailViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface PCSessionListsViewController () <PCSessionTableViewControllerDelegate>

@end

@implementation PCSessionListsViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"議程";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PCSessionTableViewController *viewControllerA = [[PCSessionTableViewController alloc] init];
    viewControllerA.delegate = self;
    viewControllerA.title = @"國際會議廳";
    
    PCSessionTableViewController *viewControllerB = [[PCSessionTableViewController alloc] init];
    viewControllerB.delegate = self;
    viewControllerB.title = @"第二會議室";
    
    self.viewControllers = @[viewControllerA, viewControllerB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PCSessionTableViewControllerDelegate

- (void)sessionTableViewController:(PCSessionTableViewController *)tableViewController didSelectRowWithData:(id)data
{
    // Use this view controller to push
    if (data) {
        DLog(@"Cell is selected");
    } else {
        DLog(@"Cell is selected, data is not available.");
    }
    
}

@end