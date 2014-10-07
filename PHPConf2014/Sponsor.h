//
//  Sponsor.h
//  PHPConf2014
//
//  Created by vincent on 2014/10/05.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SponsorType;

@interface Sponsor : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * logoURL;
@property (nonatomic, retain) NSString * siteURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *type;
@end

@interface Sponsor (CoreDataGeneratedAccessors)

- (void)addTypeObject:(SponsorType *)value;
- (void)removeTypeObject:(SponsorType *)value;
- (void)addType:(NSSet *)values;
- (void)removeType:(NSSet *)values;

@end
