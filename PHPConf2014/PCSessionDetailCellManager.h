//
//  PCSessionDetailCellCoordinator.h
//  A manager class to deal with cells of PCSessionDetailViewController, use
//  response chain to resolve switch statement smell.
//
//  Created by vincent on 2014/09/13.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PCSessionDetailCell;

@interface PCSessionDetailCellManager : NSObject

@property (nonatomic, strong) UITableView *tableView;

/*! Initialize method of this manager. Init with given tableView.
 @param tableView The given tableView to init with.
 @return the instance of the manager.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/*! Fetch the cell by given index path
 @param indexPath the index path from the table view.
 @return the cell need to be shown on the table view.
 */
- (PCSessionDetailCell *)fetchCellWithIndexPath:(NSIndexPath *)indexPath;
/*! Fetch the cell by given index path and data
 @param indexPath the index path from the table view.
 @param data the data object which is going to be used on the returned cell.
 @return the cell need to be shown on the table view.
 */
- (PCSessionDetailCell *)fetchCellWithIndexPath:(NSIndexPath *)indexPath data:(id)data;

- (CGFloat)fetchCellHeightWithIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)fetchNumberOfRowsInSection:(NSInteger)section;
@end
