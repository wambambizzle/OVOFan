//
//  UpcomingMatch.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpcomingMatch : NSObject

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *location;

//@property (strong, nonatomic) ui *homeLogo;
//@property (strong, nonatomic) UIImage *awayLogo;

- (BOOL)parseupComingMatchInfo:(NSDictionary *)nextMatchDictionary;

@end
