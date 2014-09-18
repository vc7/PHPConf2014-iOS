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
    
    self.view.backgroundColor = [UIColor phpconfExtraLightBlueColor];
    self.tableView.dataSource = self.dataSource;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

#pragma mark - Accessors

- (void)setDataSource:(id<PCSessionTableViewControllerDataSource,UITableViewDataSource>)dataSource
{
    // retain the data source
    _dataSource = dataSource;
    
    self.title = [_dataSource venueName];
    
    [self.tableView reloadData];
}

@end
