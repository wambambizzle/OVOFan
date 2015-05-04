//
//  Attendance.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "Attendance.h"

@implementation Attendance

- (instancetype)initWithAggregatedAttendance:(NSString *)aggregatedAttendance averageAttendance:(NSString *)averageAttendance largestAttendance:(NSString *)largestAttendance
{
    self = [super init];
    if (self)
    {
        _aggregatedAttendance = aggregatedAttendance;
        _averageAttendance = averageAttendance;
        _largestAttendance = largestAttendance;
    }
    
    return self;
}

+ (instancetype)attendanceStatsWithDictionary:(NSDictionary *)aDictionary
{
    Attendance *theAttendance = [[Attendance alloc] init];
    
    NSDictionary *results = [aDictionary objectForKey:@"results"];
    NSArray *stats = [results objectForKey:@"stats-attendance"];
    NSDictionary *statsDict = [stats objectAtIndex:0];
    
    theAttendance.aggregatedAttendance = [statsDict objectForKey:@"aggregatedAttendance"];
    theAttendance.averageAttendance = [statsDict objectForKey:@"averageAttendance"];
    theAttendance.largestAttendance = [statsDict objectForKey:@"largestAttendance"];
    
    return theAttendance;
}

@end
