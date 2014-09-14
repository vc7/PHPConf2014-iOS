//
//  PCSessionTableViewController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/07.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCSessionTableViewController.h"

#import "PCSessionCell.h"

#import "UIColor+PHPConfAdditions.h"

@interface PCSessionTableViewController ()

@end

@implementation PCSessionTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor phpconfLightBlueColor];
    self.cellIdentifier = @"session%@CellIdentifier";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
    [self.tableView registerClass:[PCSessionRegularCell class] forCellReuseIdentifier:[NSString stringWithFormat:self.cellIdentifier, @"Regular"]];
    [self.tableView registerClass:[PCSessionOtherCell class] forCellReuseIdentifier:[NSString stringWithFormat:self.cellIdentifier, @"Other"]];
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCSessionCell *cell;
    
    if (indexPath.row == 0 || indexPath.row == 8 || indexPath.row == 19) {
        cell = (PCSessionOtherCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:self.cellIdentifier, @"Other"] forIndexPath:indexPath];
    } else {
        cell = (PCSessionRegularCell *)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:self.cellIdentifier, @"Regular"] forIndexPath:indexPath];
    }
    
    cell.textLabel.text = @"PHPConf 議程名稱";
    cell.timeLabel.text = @"10:00 PM";
    
    if (indexPath.row == 0) {
        cell.cellState = PCSessionCellStateFirst;
    } else if (indexPath.row == 8) {
        cell.cellState = PCSessionCellStateDefault;
    } else if (indexPath.row == 19) {
        cell.cellState = PCSessionCellStateLast;
    } else {
        cell.cellState = PCSessionCellStateDefault;
    }
    
    cell.timeLabel.text = @"00:00 ~ 00:00";
    cell.textLabel.text = @"Session Name";
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Fix height to 86 points
    return 86;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCSessionCell *cell = (PCSessionCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // Push view controller only if the cell is an instance of PCSessionRegularCell (議程)
    if ([cell isKindOfClass:[PCSessionRegularCell class]]) {
        DLog(@"Session Cell is an instance of PCSessionRegularCell");
        
        if ([self.delegate respondsToSelector:@selector(sessionTableViewController:didSelectRowWithData:)]) {
            [self.delegate sessionTableViewController:self didSelectRowWithData:self.dataArray[indexPath.row]];
        }
    } else {
        DLog(@"Session Cell is an instance of PCSessionOtherCell");
    }
}

@end
