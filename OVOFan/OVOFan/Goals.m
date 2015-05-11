//
//  Goals.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "Goals.h"

@implementation Goals

- (instancetype)initWithGoals:(NSString *)goals player:(NSString *)player rank:(NSString *)rank
{
    self = [super init];
    if (self)
    {
        _goals = goals;
        _player = player;
        _rank = rank;
    }
    
    return self;
}

+ (instancetype)goalsStatsWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i
{
    Goals *aGoal = [[Goals alloc] init];
    
    NSDictionary *results = [aDictionary objectForKey:@"results"];
    NSArray *stats = [results objectForKey:@"ovo-stats-goals"];
    NSDictionary *statsDict = [stats objectAtIndex:i];
    
    aGoal.goals = [statsDict objectForKey:@"goals"];
    aGoal.rank = [statsDict objectForKey:@"rank"];
    aGoal.player = [statsDict objectForKey:@"player"];

    return aGoal;

}

@end
