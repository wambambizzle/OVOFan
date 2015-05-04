//
//  Goals.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goals : NSObject

@property (strong, nonatomic) NSString *goals;
@property (strong, nonatomic) NSString *player;
@property (strong, nonatomic) NSString *rank;

- (instancetype)initWithGoals:(NSString *)goals player:(NSString *)player rank:(NSString *)rank;

+ (instancetype)goalsStatsWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i;

@end
