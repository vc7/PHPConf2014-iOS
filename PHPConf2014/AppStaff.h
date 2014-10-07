//
//  AppStaff.h
//  PHPConf2014
//
//  Created by vincent on 2014/10/05.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppStaff : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * job;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updatedAt;

@end
