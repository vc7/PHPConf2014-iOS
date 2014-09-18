//
//  PCSessionDetailCellManager.m
//  A manager class to deal with cells of PCSessionDetailViewController, use
//  response chain to resolve switch statement smell.
//
//  Created by vincent on 2014/09/13.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCSessionDetailCellManager.h"
#import "PCSessionDetailCell.h"

static NSString *const kPCSessionDetailCellIdentifier = @"kPCSessionDetailCellIdentifier";
static NSString *const kPCSessionDetailHeroCellIdentifier = @"kPCSessionDetailHeroCellIdentifier";
static NSString *const kPCSessionDetailIntroCellIdentifier = @"kPCSessionDetailIntroCellIdentifier";
static NSString *const kPCSessionDetailSectionTitleCellIdentifier = @"kPCSessionDetailSectionTitleCellIdentifier";
static NSString *const kPCSessionDetailSectionContentCellIdentifier = @"kPCSessionDetailSectionContentCellIdentifier";

@interface PCSessionDetailCellManager ()

- (void)registerCellIdentifiers;

@end

@implementation PCSessionDetailCellManager

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self registerCellIdentifiers];
    }
    return self;
}

#pragma mark - Public Methods

- (PCSessionDetailCell *)fetchCellWithIndexPath:(NSIndexPath *)indexPath
{
    return [self fetchCellWithIndexPath:indexPath data:nil];
}

- (PCSessionDetailCell *)fetchCellWithIndexPath:(NSIndexPath *)indexPath data:(id)data
{
    switch (indexPath.section) {
            // 講者及標題, Speaker and title
        case 0:
        {
            if (indexPath.row == 0) {
                PCSessionDetailHeroCell *cell = (PCSessionDetailHeroCell *)[self.tableView dequeueReusableCellWithIdentifier:kPCSessionDetailHeroCellIdentifier forIndexPath:indexPath];
                cell.speakerName = @"講者名稱";
                cell.speakerPosition = @"講者職稱";
                return cell;
            } else {
                PCSessionDetailIntroCell *cell = (PCSessionDetailIntroCell *)[self.tableView dequeueReusableCellWithIdentifier:kPCSessionDetailIntroCellIdentifier forIndexPath:indexPath];
                cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = @"PHP 開發實務，補齊遺失的一些東東西西東東西西。";
                
                return cell;
            }
        }
            break;
        // 關於講題, Session detail
        case 1:
        {
            if (indexPath.row == 0) {
                PCSessionDetailSectionTitleCell *cell = (PCSessionDetailSectionTitleCell *)[self.tableView dequeueReusableCellWithIdentifier:kPCSessionDetailSectionTitleCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = @"關於講題";
                return cell;
            } else {
                PCSessionDetailSectionContentCell *cell = (PCSessionDetailSectionContentCell *)[self.tableView dequeueReusableCellWithIdentifier:kPCSessionDetailSectionContentCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = @"講題內容好多好多字，講很久都講不完。講完就天黑了，所以就不要講好了。";
                return cell;
            }
        }
            break;
        // 關於講者, About speaker
        case 2:
        {
            if (indexPath.row == 0) {
                PCSessionDetailSectionTitleCell *cell = (PCSessionDetailSectionTitleCell *)[self.tableView dequeueReusableCellWithIdentifier:kPCSessionDetailSectionTitleCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = @"關於講者";
                return cell;
            } else {
                PCSessionDetailSectionContentCell *cell = (PCSessionDetailSectionContentCell *)[self.tableView dequeueReusableCellWithIdentifier:kPCSessionDetailSectionContentCellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = @"講者相關背景的內容有好多好多字，講很久都講不完。講完就天黑了，所以就不要講好了。";
                return cell;
            }
        }
            break;
        default:
            break;
    }
    
    PCSessionDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPCSessionDetailCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (CGFloat)fetchCellHeightWithIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        // 講者及標題, Speaker and title
        case 0:
            if (indexPath.row == 0) {
                return 242;
            } else {
                return 78;
            }
        // 關於講題, Session detail
        case 1:
            if (indexPath.row == 0) {
                return 35; // title
            } else {
                return 50;
            }
        // 關於講者, About speaker
        case 2:
            if (indexPath.row == 0) {
                return 35; // title
            } else {
                return 50; // title
            }
        default:
            break;
    }
    return 0;
}

- (NSInteger)fetchNumberOfRowsInSection:(NSInteger)section
{
    switch (section) {
            // 講者及標題, Speaker and title
        case 0:
            return 2;
            // 關於講題, Session detail
        case 1:
            return 2;
            // 關於講者, About speaker
        case 2:
            return 2;
        default:
            break;
    }
    return 0;
}

#pragma mark - Private Methods

- (void)registerCellIdentifiers
{
    [self.tableView registerClass:[PCSessionDetailCell class] forCellReuseIdentifier:kPCSessionDetailCellIdentifier];
    [self.tableView registerClass:[PCSessionDetailHeroCell class] forCellReuseIdentifier:kPCSessionDetailHeroCellIdentifier];
    [self.tableView registerClass:[PCSessionDetailIntroCell class] forCellReuseIdentifier:kPCSessionDetailIntroCellIdentifier];
    [self.tableView registerClass:[PCSessionDetailSectionTitleCell class] forCellReuseIdentifier:kPCSessionDetailSectionTitleCellIdentifier];
    [self.tableView registerClass:[PCSessionDetailSectionContentCell class] forCellReuseIdentifier:kPCSessionDetailSectionContentCellIdentifier];
}

@end
