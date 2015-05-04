//
//  Assists.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Assists : NSObject

@property (strong, nonatomic) NSString *assist;
@property (strong, nonatomic) NSString *player;
@property (strong, nonatomic) NSString *rank;

- (instancetype)initWithAssist:(NSString *)assist player:(NSString *)player rank:(NSString *)rank;

+ (instancetype)attendanceStatsWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i;

@end
