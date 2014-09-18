//
//  PCNewsListViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/04.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCNewsListViewController.h"
#import "PCNewsCell.h"

#import "UIColor+PHPConfAdditions.h"

@interface PCNewsListViewController ()

@end

@implementation PCNewsListViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"最新消息";
        self.tableView.backgroundColor = [UIColor phpconfExtraLightBlueColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCNewsCell *cell = [[PCNewsCell alloc] init];
    cell.newsContent = @"This is a news content. This is a news content. This is a news content. This is a news content. This is a news content.";
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
