//
//  PCVenueMapMainViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/15.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCVenueMapMainViewController.h"

#import "PCMainTitleCell.h"
#import "PCSecondaryTitleCell.h"
#import "PCContentCell.h"
#import "PCMapCell.h"

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"
#import "UILabel+height.h"

static NSString *const kPCVenueMapMainMainTitleCellIdentifier = @"kPCVenueMapMainMainTitleCellIdentifier";
static NSString *const kPCVenueMapMainSecondaryTitleCellIdentifier = @"kPCVenueMapMainSecondaryTitleCellIdentifier";
static NSString *const kPCVenueMapMainContentCellIdentifier = @"kPCVenueMapMainContentCellIdentifier";
static NSString *const kPCVenueMapMainMapCellIdentifier = @"kPCVenueMapMainMapCellIdentifier";

@interface PCVenueMapMainViewController ()

@end

@implementation PCVenueMapMainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"地圖";
        self.tableView.backgroundColor = [UIColor phpconfExtraLightBlueColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.tableView registerClass:[PCMainTitleCell class] forCellReuseIdentifier:kPCVenueMapMainMainTitleCellIdentifier];
        [self.tableView registerClass:[PCSecondaryTitleCell class] forCellReuseIdentifier:kPCVenueMapMainSecondaryTitleCellIdentifier];
        [self.tableView registerClass:[PCContentCell class] forCellReuseIdentifier:kPCVenueMapMainContentCellIdentifier];
        [self.tableView registerClass:[PCMapCell class] forCellReuseIdentifier:kPCVenueMapMainMapCellIdentifier];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        PCMapCell *cell = (PCMapCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        [cell initializeMapViewIfNeeded];
    });
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PCMainTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCVenueMapMainMainTitleCellIdentifier forIndexPath:indexPath];
        
        cell.textLabel.text = @"輔仁大學位置圖";
        
        return cell;
    } else if (indexPath.row == 1) {
        PCContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCVenueMapMainContentCellIdentifier forIndexPath:indexPath];
        
        NSString *contentString = @"地址：新北市新莊區中正路510號";
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:contentString];
        [content addAttribute:NSFontAttributeName value:[UIFont phpconfBoldFontSize:12.f] range:NSMakeRange(0, 3)];
        [content addAttribute:NSFontAttributeName value:[UIFont phpconfFontSize:12.f] range:NSMakeRange(3, contentString.length - 3)];
        
        cell.textLabel.attributedText = content;
        
        return cell;
    } else if (indexPath.row == 2) {
        PCMapCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCVenueMapMainMapCellIdentifier forIndexPath:indexPath];
        
        return cell;
    } else if (indexPath.row == 3){
        PCSecondaryTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCVenueMapMainSecondaryTitleCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"捷運站及公車轉乘班次資訊";
        return cell;
    } else if (indexPath.row == 4){
        PCContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCVenueMapMainContentCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"台北車站捷運站: 513\n\n台大醫院捷運站: 513\n\n西門捷運站: 235、513、635、637、藍2\n\n民權西路捷運站: 636、638、801\n\n新埔捷運站: 99、802、842、845\n\n\n輔大捷運站:\n\n1. 輔仁大學門口公車站: 藍2、橘21、99、111、235、635、363、637、638、639、663、801、802、810、842、845、藍2、1501、1502、1503、1508、1510、1515、1803、5009、5075、5675、9102\n\n2. 三重客運輔大站: 513\n\n3. 建國一路輔大站: 299、615、618";
        return cell;
    } else if (indexPath.row == 5){
        PCSecondaryTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCVenueMapMainSecondaryTitleCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"路線指示";
        return cell;
    } else {
        PCContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCVenueMapMainContentCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"一、輔大校門進入直行至最後端至中美堂，左轉第2棟有玻璃帷幕之新大樓即為國璽樓\n\n二、自輔大貴子門進入，右轉第一棟大樓即為國璽樓。";
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 64;
    } else if (indexPath.row == 1) {
        return 44;
    } else if (indexPath.row == 2) {
        return 200;
    } else if (indexPath.row == 3 || indexPath.row == 5) {
        return 44;
    } else if (indexPath.row == 4) {
        NSString *content = @"台北車站捷運站: 513\n\n台大醫院捷運站: 513\n\n西門捷運站: 235、513、635、637、藍2\n\n民權西路捷運站: 636、638、801\n\n新埔捷運站: 99、802、842、845\n\n\n輔大捷運站:\n\n1. 輔仁大學門口公車站: 藍2、橘21、99、111、235、635、363、637、638、639、663、801、802、810、842、845、藍2、1501、1502、1503、1508、1510、1515、1803、5009、5075、5675、9102\n\n2. 三重客運輔大站: 513\n\n3. 建國一路輔大站: 299、615、618";
        return [UILabel findHeightForText:content havingWidth:CGRectGetWidth(tableView.frame) - 10 andFont:[UIFont phpconfFontSize:14.f]] + 20;
    } else {
        NSString *content = @"一、輔大校門進入直行至最後端至中美堂，左轉第2棟有玻璃帷幕之新大樓即為國璽樓\n\n二、自輔大貴子門進入，右轉第一棟大樓即為國璽樓。";
        return [UILabel findHeightForText:content havingWidth:CGRectGetWidth(tableView.frame) - 10 andFont:[UIFont phpconfFontSize:14.f]] + 20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        DLog(@"Map selected");
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"comgooglemaps-x-callback://?center=25.0355647,121.4320238&q=%E8%BC%94%E4%BB%81%E5%A4%A7%E5%AD%B8&x-success=phpconftw2014://?resume=true&x-source=PHPConf%20Taiwan%202014"]];
        }
    }
}

@end
