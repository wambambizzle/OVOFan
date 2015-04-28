//
//  Schedule.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "Schedule.h"

@interface Schedule ()


@end

@implementation Schedule

- (instancetype)initWithResultsDic:(NSString *)zip
{
    self = [super init];
    if (self)
    {
//        _zipCode = zip;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipcode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
//        _name = name;
//        _latitude = lat;
//        _longitude = lng;
//        _zipCode = zip;
//        _coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    
    return self;
}

- (BOOL)parseScheduleInfo:(NSDictionary *)scheduleDictionary
{
    return YES;
}

@end
