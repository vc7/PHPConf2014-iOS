//
//  PCInfoListsViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/04.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCInfoListsViewController.h"

#import "PCInfoPHPConfViewController.h"
#import "PCInfoSponsorViewController.h"
#import "PCInfoStaffViewController.h"

#import "UIImage+PDF.h"

@interface PCInfoListsViewController ()

@end

@implementation PCInfoListsViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"關於";
        self.tabBarItem.image = [UIImage imageWithPDFNamed:@"tab_icon.pdf" fitSize:(CGSize){30, 30} atPage:3];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PCInfoPHPConfViewController *phpconfViewController = [[PCInfoPHPConfViewController alloc] init];
    PCInfoSponsorViewController *sponsorViewController = [[PCInfoSponsorViewController alloc] init];
    PCInfoStaffViewController *staffViewController = [[PCInfoStaffViewController alloc] init];
    
    self.viewControllers = @[phpconfViewController, sponsorViewController, staffViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
