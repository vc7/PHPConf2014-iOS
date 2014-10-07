//
//  StaffDepartmentRelation.h
//  PHPConf2014
//
//  Created by vincent on 2014/10/05.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Staff;

@interface StaffDepartmentRelation : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * isLeader;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *staff;
@property (nonatomic, retain) NSSet *team;
@end

@interface StaffDepartmentRelation (CoreDataGeneratedAccessors)

- (void)addStaffObject:(Staff *)value;
- (void)removeStaffObject:(Staff *)value;
- (void)addStaff:(NSSet *)values;
- (void)removeStaff:(NSSet *)values;

- (void)addTeamObject:(NSManagedObject *)value;
- (void)removeTeamObject:(NSManagedObject *)value;
- (void)addTeam:(NSSet *)values;
- (void)removeTeam:(NSSet *)values;

@end
