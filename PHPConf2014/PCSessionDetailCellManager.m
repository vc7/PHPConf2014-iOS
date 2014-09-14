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

@interface PCSessionDetailCellManager ()

- (void)registerCellIdentifiers;

@end

@implementation PCSessionDetailCellManager

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
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
    PCSessionDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Private Methods

- (void)registerCellIdentifiers
{
    //TODO: to be implemented
}

@end
