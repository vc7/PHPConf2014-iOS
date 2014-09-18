//
//  PCInfoPHPConfViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/15.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PCInfoPHPConfViewController.h"

#import "PCMainTitleCell.h"
#import "PCContentCell.h"

#import "UIColor+PHPConfAdditions.h"
#import "UIFont+PHPConfAdditions.h"

static NSString *const kPCInfoPHPConfMainTitleCellIdentifier = @"kPCInfoPHPConfMainTitleCellIdentifier";
static NSString *const kPCInfoPHPConfContentCellIdentifier = @"kPCInfoPHPConfContentCellIdentifier";

@implementation PCInfoPHPConfViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"PHPConf";
        self.tableView.backgroundColor = [UIColor phpconfExtraLightBlueColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.tableView registerClass:[PCMainTitleCell class] forCellReuseIdentifier:kPCInfoPHPConfMainTitleCellIdentifier];
        [self.tableView registerClass:[PCContentCell class] forCellReuseIdentifier:kPCInfoPHPConfContentCellIdentifier];
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
        PCMainTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCInfoPHPConfMainTitleCellIdentifier forIndexPath:indexPath];
        
        cell.textLabel.text = @"關於 PHPConf";
        
        return cell;
    } else {
        PCContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kPCInfoPHPConfContentCellIdentifier forIndexPath:indexPath];
        
        NSString *contentString = @"歷經三屆的 PHPConf Taiwan ，在每位 PHP 開發者的參與下，主題從 2011 年以 PHP 開發相關工具的介紹來初試啼聲，到 2012 年著重 PHP Framework 的推廣，乃至去年以 PHP 實戰經驗為主的分享，使得我們相信在這三年不斷地挑戰下，各位 PHP 開發者都有很大的成長。\n\n因此今年我們希望讓將議程廣度擴大，挑戰許多 PHP 開發者平常難以接觸的主題，例如專案管理、 NoSQL 應用與資料庫擴展以及 PHP 網站服務開發心得，讓與會者能得到專案開發與架構上的借鏡。但我們依然會維持過去議程的深度，加入更多 PHP 進階技術，例如官方 PHP 與 Facebook HHVM 兩種引擎在 Extension 上的開發經驗， Framework 的應用技巧等議題。\n\n另外 PHP 應用程式的佈署技術，例如 Microsoft Azure 、 Docker 等更是每一位開發者都應該關心的議題。最後我們還邀請到 PHP 核心中國開發成員 Laruence ，分享他在微博上應用 PHP 的開發經驗。想要更深入瞭解 PHP 進階技術，或是如何掌控大型網站架構的朋友，千萬別錯過這些高手們交流的機會。\n\n身為台灣最大型的 PHP 研討會，除了議程分享外， PHPConf Taiwan 2014 同時也是企業尋找 PHP 人才的最佳管道；當全台灣 PHP 界的各路英雄好漢都齊聚一堂時，就是各企業秀出手上最棒職務的機會！\n\n最後感謝每一家贊助單位的支持，為 PHPConf Taiwan 2014 提供舉辦時所需要的資源與場地。我們將會盡我們一切的努力，來讓今年的 PHPConf Taiwan 更為精采可期！";
        
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
        return 550;
    }
}

@end
