//
//  Conference.h
//  PHPConf2014
//
//  Created by vincent on 2014/10/05.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Conference : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * logoURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;

@end
