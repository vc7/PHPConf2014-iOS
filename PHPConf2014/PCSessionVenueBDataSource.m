//
//  PCSessionVenueBDataSource.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/16.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCSessionVenueBDataSource.h"
#import "PCSessionCell.h"

@implementation PCSessionVenueBDataSource

- (NSString *)venueName
{
    return @"國璽樓二樓";
}

- (NSArray *)dataArray
{
    return @[
             @{@"startAt":@"09:00",
               @"endAt":@"09:20",
               @"title":@"報到",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"09:20",
               @"endAt":@"09:30",
               @"title":@"開幕",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"9:30",
               @"endAt":@"10:40",
               @"title":@"Building High available and scalable website from Microsoft Azure",
               @"speaker":@"方鶴",
               @"type":@"regular",
               },
             @{@"startAt":@"10:40",
               @"endAt":@"10:50",
               @"title":@"休息",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"10:50",
               @"endAt":@"11:30",
               @"title":@"選舉黃頁開發經驗分享",
               @"speaker":@"Kiang",
               @"type":@"regular",
               },
             @{@"startAt":@"11:30",
               @"endAt":@"12:30",
               @"title":@"午餐",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"12:30",
               @"endAt":@"13:20",
               @"title":@"Framework or Framework Less",
               @"speaker":@"蒼時弦也",
               @"type":@"regular",
               },
             @{@"startAt":@"13:20",
               @"endAt":@"13:30",
               @"title":@"休息",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"13:30",
               @"endAt":@"14:10",
               @"title":@"Scalability in Mind - 當老軟體Drupal遇上大架構",
               @"speaker":@"Jimmy Huang",
               @"type":@"regular",
               },
             @{@"startAt":@"14:10",
               @"endAt":@"14:40",
               @"title":@"下午茶",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"14:40",
               @"endAt":@"15:10",
               @"title":@"HTTP accelerator - Varnish 應用",
               @"speaker":@"Ninja",
               @"type":@"regular",
               },
             @{@"startAt":@"15:10",
               @"endAt":@"15:20",
               @"title":@"休息",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"15:20",
               @"endAt":@"16:00",
               @"title":@"運用 Docker 部署PHP專案",
               @"speaker":@"Fntsrlike",
               @"type":@"regular",
               },
             @{@"startAt":@"16:00",
               @"endAt":@"16:10",
               @"title":@"休息",
               @"speaker":@"",
               @"type":@"other",
               },
             @{@"startAt":@"16:10",
               @"endAt":@"16:50",
               @"title":@"MySQL 的效能救贖：Percona XtraDB Cluster",
               @"speaker":@"Nekobe",
               @"type":@"regular",
               },
             @{@"startAt":@"16:50",
               @"endAt":@"17:00",
               @"title":@"閉幕",
               @"speaker":@"",
               @"type":@"other",
               },
             ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self dataArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCSessionCell *cell;
    
    NSDictionary *data = [self dataArray][indexPath.row];
    
    if ([data[@"type"] isEqualToString:@"other"]) {
        cell = (PCSessionOtherCell *)[tableView dequeueReusableCellWithIdentifier:@"Other"];
        if (!cell) {
            cell = [[PCSessionOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Other"];
        }
    } else {
        cell = (PCSessionRegularCell *)[tableView dequeueReusableCellWithIdentifier:@"Regular"];
        if (!cell) {
            cell = [[PCSessionRegularCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Regular"];
        }
    }
    
    if (indexPath.row == 0) {
        cell.cellState = PCSessionCellStateFirst;
    } else if (indexPath.row == [self dataArray].count - 1) {
        cell.cellState = PCSessionCellStateLast;
    } else {
        cell.cellState = PCSessionCellStateDefault;
    }
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", data[@"startAt"], data[@"endAt"]];
    cell.textLabel.text = data[@"title"];
    
    return cell;
}

@end
