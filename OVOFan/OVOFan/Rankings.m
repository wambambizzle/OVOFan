//
//  Rankings.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "Rankings.h"

@implementation Rankings

- (instancetype)initWithClubName:(NSString *)clubName goalDiff:(NSString *)goalDiff pointsScored:(NSString *)pointsScored position:(NSString *)position;
{
    self = [super init];
    if (self)
    {
        _clubName = clubName;
        _goalDiff = goalDiff;
        _pointsScored = pointsScored;
        _position = position;
    }
    
    return self;
}

+ (instancetype)leagueStandingWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i
{
    Rankings *aRank = [[Rankings alloc] init];
    
    NSDictionary *results = [aDictionary objectForKey:@"results"];
    NSArray *rankings = [results objectForKey:@"rankings"];
    NSDictionary *rankingsDict = [rankings objectAtIndex:i];
    

    aRank.clubName = [rankingsDict objectForKey:@"club"];
    aRank.goalDiff = [rankingsDict objectForKey:@"goal difference"];
    aRank.pointsScored = [rankingsDict objectForKey:@"points"];
    aRank.position = [rankingsDict objectForKey:@"position"];
    
    return aRank;

}

@end
