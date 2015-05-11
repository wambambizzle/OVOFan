//
//  Assists.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "Assists.h"

@implementation Assists

- (instancetype)initWithAssist:(NSString *)assist player:(NSString *)player rank:(NSString *)rank
{
    self = [super init];
    if (self)
    {
        _assist = assist;
        _player = player;
        _rank = rank;
    }
    
    return self;
}

+ (instancetype)assistStatsWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i
{
    Assists *anAssist = [[Assists alloc] init];
    
    NSDictionary *results = [aDictionary objectForKey:@"results"];
    NSArray *stats = [results objectForKey:@"stats-assist"];
    NSDictionary *statsDict = [stats objectAtIndex:i];
    
    anAssist.assist = [statsDict objectForKey:@"assists"];
    anAssist.rank = [statsDict objectForKey:@"rank"];
    anAssist.player = [statsDict objectForKey:@"players"];
    
    return anAssist;
    
}

@end
