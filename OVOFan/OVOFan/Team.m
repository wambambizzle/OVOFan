//
//  Team.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "Team.h"

@implementation Team

- (instancetype)initWithPlayerImage:(UIImage *)playerImage age:(NSString *)age height:(NSString *)height name:(NSString *)name position:(NSString *)position number:(NSString *)number detailsLink:(NSString *)detailsLink AndWeight:(NSString *)weight
{
    self = [super init];
    if (self)
    {
        _playerImage = playerImage;
        _age = age;
        _height = height;
        _name = name;
        _position = position;
        _number = number;
        _weight = weight;
    }
    
    return self;
}

+ (instancetype)teamWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i
{
    Team *aPlayer = [[Team alloc] init];
    
    NSDictionary *results = [aDictionary objectForKey:@"results"];
    NSArray *squad = [results objectForKey:@"Squad"];
    NSDictionary *squadDict = [squad objectAtIndex:i];
    
    NSDictionary *imageDic = [squadDict objectForKey:@"image"];
    
    NSString *imgSrcString = [imageDic objectForKey:@"src"];
    
    imgSrcString = [imgSrcString stringByReplacingOccurrencesOfString:@" "
                                                       withString:@"%20"];
    
    NSURL *imgURL = [NSURL URLWithString: imgSrcString];
    NSData *playerImgData = [NSData dataWithContentsOfURL:imgURL];
    aPlayer.playerImage = [UIImage imageWithData:playerImgData];
    aPlayer.detailsLink = [imageDic objectForKey:@"href"];

    aPlayer.age = [squadDict objectForKey:@"age"];
    aPlayer.height = [squadDict objectForKey:@"height"];
    aPlayer.name = [squadDict objectForKey:@"name"];
    aPlayer.number = [squadDict objectForKey:@"number"];
    aPlayer.position = [squadDict objectForKey:@"position"];
    aPlayer.weight = [squadDict objectForKey:@"weight"];
    
    
    return aPlayer;
}




@end
