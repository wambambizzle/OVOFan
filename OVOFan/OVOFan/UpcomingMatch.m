//
//  UpcomingMatch.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "UpcomingMatch.h"

@implementation UpcomingMatch

- (instancetype)initWithDate:(NSString *)date location:(NSString *)location time:(NSString *)time homeLogo:(UIImage *)homeLogo andAwayLogo:(UIImage *)awayLogo
{
    self = [super init];
    if (self)
    {
        _date = date;
        _location = location;
        _time = time;
        _homeLogo = homeLogo;
        _awayLogo = awayLogo;
    }
    
    return self;
}

- (BOOL)parseupComingMatchInfo:(NSDictionary *)nextMatchDictionary
{
    BOOL rc = NO;
    
    if (nextMatchDictionary)
    {
        NSDictionary *results = [nextMatchDictionary objectForKey:@"results"];
        NSArray *nextGame = [results objectForKey:@"Next Game"];
        NSDictionary *next = nextGame[0];
        self.date = [next objectForKey:@"date"];
        self.location = [next objectForKey:@"location"];
        self.time = [next objectForKey:@"time"];
        
        NSArray *clubLogos = [results objectForKey:@"Club Logos"];
        NSDictionary *homeLogoDic = clubLogos[0];
//        NSLog(@"%@", [homeLogoDic objectForKey:@"clubLogos"]);
        NSString *homeString = [homeLogoDic objectForKey:@"clubLogos"];
        
        homeString = [homeString stringByReplacingOccurrencesOfString:@" "
                                            withString:@"%20"]; // or look up stringbyaddingpercentencoding method -char set
        
        NSURL *homeIconURL = [NSURL URLWithString:homeString];
        NSData *homeImgData = [NSData dataWithContentsOfURL:homeIconURL];
        self.homeLogo = [UIImage imageWithData:homeImgData];
        NSDictionary *awayLogoDic = clubLogos[1];
        NSURL *awayIconURL = [NSURL URLWithString:[awayLogoDic objectForKey:@"clubLogos"]];
        NSData *awayImgData = [NSData dataWithContentsOfURL:awayIconURL];
        self.awayLogo = [UIImage imageWithData:awayImgData];
        rc = YES;
        
 // JNA - turn this img from url into an Ansyncronus call
    
    }
    return rc;
}

@end
