//
//  PCDataSpecDefines.m
//  PHPConf2014
//
//  Created by vincent on 2014/08/28.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCDataSpecDefines.h"
#import "PCKDataSpecProtocol.h"
#import "PCDefines.h"

@implementation PCDataSpecDefines

- (NSString *)requestTemplate
{
    return kPCDSRequestTemplate;
}

- (NSString *)dataVersion
{
    return kPCDSDataVersion;
}

- (NSString *)sessionR0
{
    return kPCDSSessionR0;
}

- (NSString *)sessionR2
{
    return kPCDSSessionR2;
}

- (NSString *)venueMap
{
    return kPCDSVenueMap;
}

- (NSString *)sponsorGold
{
    return kPCDSSponsorGold;
}

- (NSString *)sponsorSilver
{
    return kPCDSSponsorSilver;
}

- (NSString *)sponsorDiamond
{
    return kPCDSSponsorDiamond;
}

- (NSString *)sponsorSpecialThanks
{
    return kPCDSSponsorSpecialThanks;
}

- (NSString *)confBulletin
{
    return kPCDSConfBulletin;
}

- (NSString *)confAbout
{
    return kPCDSConfAbout;
}

- (NSString *)confTeam
{
    return kPCDSConfTeam;
}

- (NSString *)appTeam
{
    return kPCDSAppTeam;
}

@end
