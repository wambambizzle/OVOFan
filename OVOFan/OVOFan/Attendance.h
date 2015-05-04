//
//  Attendance.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attendance : NSObject

@property (strong, nonatomic) NSString *aggregatedAttendance;
@property (strong, nonatomic) NSString *averageAttendance;
@property (strong, nonatomic) NSString *largestAttendance;

- (instancetype)initWithAggregatedAttendance:(NSString *)aggregatedAttendance averageAttendance:(NSString *)averageAttendance largestAttendance:(NSString *)largestAttendance;

+ (instancetype)attendanceStatsWithDictionary:(NSDictionary *)aDictionary;

@end
