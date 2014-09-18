//
//  PCInfoSponsorViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/15.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCInfoSponsorViewController.h"

#import "PCMainTitleCell.h"
#import "PCContentCell.h"

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"

static NSString *const kPCInfoSponsorMainTitleCellIdentifier = @"kPCInfoSponsorMainTitleCellIdentifier";
static NSString *const kPCInfoSponsorContentCellIdentifier = @"kPCInfoSponsorContentCellIdentifier";

@interface PCInfoSponsorViewController ()

@end

@implementation PCInfoSponsorViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"贊助商";
        self.tableView.backgroundColor = [UIColor phpconfExtraLightBlueColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.tableView registerClass:[PCMainTitleCell class] forCellReuseIdentifier:kPCInfoSponsorMainTitleCellIdentifier];
        [self.tableView registerClass:[PCContentCell class] forCellReuseIdentifier:kPCInfoSponsorContentCellIdentifier];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PCMainTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCInfoSponsorMainTitleCellIdentifier forIndexPath:indexPath];
        
        cell.textLabel.text = @"贊助商";
        
        return cell;
    } else {
        PCContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCInfoSponsorContentCellIdentifier forIndexPath:indexPath];
        
        NSString *contentString = @"贊助商資料整理中";
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:contentString];
        [content addAttribute:NSFontAttributeName value:[UIFont phpconfFontSize:12.f] range:NSMakeRange(0, contentString.length)];
        [content addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentString.length)];
        
        cell.textLabel.attributedText = content;
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 64;
    } else {
        return 44;
    }
}

@end
