//
//  PCHUDManager.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/14.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCHUDManager.h"

@interface PCHUDManager ()

@end

@implementation PCHUDManager

+ (instancetype)defaultManager {
    static dispatch_once_t pred;
    static PCHUDManager *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[PCHUDManager alloc] init];
    });
    return shared;
}

@end
