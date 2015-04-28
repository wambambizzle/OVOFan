//
//  UpcomingMatch.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "UpcomingMatch.h"

@implementation UpcomingMatch

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipcode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
        //        _name = name;
        //        _latitude = lat;
        //        _longitude = lng;
        //        _zipCode = zip;
        //        _coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    
    return self;
}

- (BOOL)parseupComingMatchInfo:(NSDictionary *)nextMatchDictionary
{
    if (nextMatchDictionary)
    {
        NSDictionary *results = [nextMatchDictionary objectForKey:@"results"];
        NSArray *nextGame = [results objectForKey:@"Next Game"];
        NSDictionary *next = nextGame[0];
        self.date = [next objectForKey:@"date"];
        self.location = [next objectForKey:@"location"];
        self.time = [next objectForKey:@"time"];
        
//        NSArray *categories = [aVenue objectForKey:@"categories"];
//        NSDictionary *iconA = [categories objectAtIndex:0];
//        NSDictionary *iconTrue = [iconA objectForKey:@"icon"];
//        NSString *prefix = [iconTrue objectForKey:@"prefix"];
//        NSString *suffix = [iconTrue objectForKey:@"suffix"];
//        
//        NSString *icon = [NSString stringWithFormat:@"%@44%@", prefix, suffix];
//        NSURL *iconURL = [NSURL URLWithString:icon];
//        NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
//        UIImage *image = [UIImage imageWithData:imageData];
//        cell.imageView.image = image;
        
        
        
        

        
    }
    return YES;
}

@end
