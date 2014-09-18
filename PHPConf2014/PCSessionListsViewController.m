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
#import "PCSessionVenueADataSource.h"
#import "PCSessionVenueBDataSource.h"

#import "PCHUDManager.h"
#import "UIFont+PHPConfAdditions.h"

#import <MBProgressHUD/MBProgressHUD.h>
#import "UIImage+PDF.h"

@interface PCSessionListsViewController () <PCSessionTableViewControllerDelegate>

@end

@implementation PCSessionListsViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"議程";
        self.tabBarItem.image = [UIImage imageWithPDFNamed:@"tab_icon.pdf" fitSize:(CGSize){30, 30} atPage:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PCSessionTableViewController *firstRoomViewController = [[PCSessionTableViewController alloc] init];
    firstRoomViewController.delegate = self;
    firstRoomViewController.dataSource = [[PCSessionVenueADataSource alloc] init];
    
    PCSessionTableViewController *secondRoomViewController = [[PCSessionTableViewController alloc] init];
    secondRoomViewController.delegate = self;
    secondRoomViewController.dataSource = [[PCSessionVenueBDataSource alloc] init];
    
    UIViewController *viewControllerC = [[UIViewController alloc] init];
    viewControllerC.title = @"講者";
    
    self.viewControllers = @[firstRoomViewController, secondRoomViewController];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont phpconfFontSize:16.f]} forState:UIControlStateNormal];
    
    self.navigationItem.backBarButtonItem = backBarButtonItem;
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
        
        //PCSessionDetailViewController *sessionDetailViewController = [[PCSessionDetailViewController alloc] initWithStyle:UITableViewStylePlain];
        
        //[self.navigationController pushViewController:sessionDetailViewController animated:YES];
        
    } else {
        DLog(@"Cell has no data to display");
        [PCHUDManager defaultManager].progressHUD.mode = MBProgressHUDModeText;
        [PCHUDManager defaultManager].progressHUD.labelText = @"此議程目前尚無詳細資料";
        
        [[PCHUDManager defaultManager] showHUDWithAutoHide];
    }
}

@end