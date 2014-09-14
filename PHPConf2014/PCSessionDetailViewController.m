//
//  PCSessionDetailViewController.m
//  This is the view controller to show a session's detail information
//
//  Created by vincent on 2014/09/13.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCSessionDetailViewController.h"

#import "PCSessionDetailCell.h"
#import "PCSessionDetailCellManager.h"

@interface PCSessionDetailViewController ()

@property (nonatomic, strong) PCSessionDetailCellManager *cellManager;

@end

@implementation PCSessionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 0 - 講者及標題
    // 1 - 關於講題
    // 2 - 關於講者
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        // 講者及標題, Speaker and title
        case 0:
            return 2;
        // 關於講題, Session detail
        case 1:
            return 1;
        // 關於講者, About speaker
        case 2:
            return 1;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellManager fetchCellWithIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - Accessors

- (PCSessionDetailCellManager *)cellManager
{
    if (!_cellManager) {
        _cellManager = [[PCSessionDetailCellManager alloc] initWithTableView:self.tableView];
    }
    
    return _cellManager;
}

@end
