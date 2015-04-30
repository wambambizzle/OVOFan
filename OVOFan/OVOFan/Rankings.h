//
//  Rankings.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rankings : NSObject

@property (strong, nonatomic) NSString *clubName;
@property (strong, nonatomic) NSString *goalDiff;
@property (strong, nonatomic) NSString *pointsScored;
@property (strong, nonatomic) NSString *position;


- (instancetype)initWithClubName:(NSString *)clubName goalDiff:(NSString *)goalDiff pointsScored:(NSString *)pointsScored position:(NSString *)position;

+ (instancetype)leagueStandingWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i;

@end
