//
//  PCSessionDetailCellCoordinator.h
//  A coordinator class to deal with cells of PCSessionDetailViewController, use
//  response chain to resolve switch statement smell.
//
//  Created by vincent on 2014/09/13.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCSessionDetailCellCoordinator : NSObject

@property (nonatomic, strong) UITableView *tableView;

/*! Initialize method of this coordinator. Init with given tableView.
 @param tableView The given tableView to init with.
 @return the instance of the coordinator.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

@end
