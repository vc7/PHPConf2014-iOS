//
//  Session.h
//  PHPConf2014
//
//  Created by vincent on 2014/10/05.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * endedAt;
@property (nonatomic, retain) NSNumber * isRegular;
@property (nonatomic, retain) NSDate * startedAt;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSManagedObject *speaker;
@property (nonatomic, retain) NSSet *venue;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)addVenueObject:(Venue *)value;
- (void)removeVenueObject:(Venue *)value;
- (void)addVenue:(NSSet *)values;
- (void)removeVenue:(NSSet *)values;

@end
