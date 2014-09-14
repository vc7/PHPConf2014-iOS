//
//  PCSessionTableViewController.h
//  PHPConf2014
//
//  Created by vincent on 2014/09/07.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PCSessionTableViewControllerDelegate;

@interface PCSessionTableViewController : UITableViewController

@property (nonatomic, weak) id <PCSessionTableViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSArray *dataArray;

@end

@protocol PCSessionTableViewControllerDelegate <NSObject>

@optional

- (void)sessionTableViewController:(PCSessionTableViewController *)tableViewController didSelectRowWithData:(id)data;

@end