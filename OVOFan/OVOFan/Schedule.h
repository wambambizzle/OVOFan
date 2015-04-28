//
//  Schedule.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Schedule : NSObject

@property (strong, nonatomic) NSString *homeClubName;


- (BOOL)parseScheduleInfo:(NSDictionary *)scheduleDictionary;

@end
