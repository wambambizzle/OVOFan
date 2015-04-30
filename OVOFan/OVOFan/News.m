//
//  News.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/29/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)initWithArticleTitle:(NSString *)articleTitle date:(NSString *)date articleImage:(UIImage *)articleImage
{
    self = [super init];
    if (self)
    {
        _articleTitle = articleTitle;
        _date = date;
        _articleImage = articleImage;
    }
    
    return self;
}

//+ (instancetype)newsArticleWithDictionary:(NSDictionary *)newsDictionary
//{
//    
////    if (newsDictionary)
////    {
////        News *anArticle = [[News alloc] init];
////        NSDictionary *results = [newsDictionary objectForKey:@"results"];
////        NSArray *article = [results objectForKey:@"Article"];
////        for (NSDictionary *anArticle in article)
////        {
////       
////
////        }
//////        self.date = [next objectForKey:@"date"];
//////        self.location = [next objectForKey:@"location"];
//////        self.time = [next objectForKey:@"time"];
//////        
//////        NSArray *clubLogos = [results objectForKey:@"Club Logos"];
//////        NSDictionary *homeLogoDic = clubLogos[0];
//////        //        NSLog(@"%@", [homeLogoDic objectForKey:@"clubLogos"]);
//////        NSString *homeString = [homeLogoDic objectForKey:@"clubLogos"];
//////        NSURL *homeIconURL = [NSURL URLWithString:homeString];
//////        NSData *homeImgData = [NSData dataWithContentsOfURL:homeIconURL];
//////        self.homeLogo = [UIImage imageWithData:homeImgData];
//////        NSDictionary *awayLogoDic = clubLogos[1];
//////        NSURL *awayIconURL = [NSURL URLWithString:[awayLogoDic objectForKey:@"clubLogos"]];
//////        NSData *awayImgData = [NSData dataWithContentsOfURL:awayIconURL];
//////        self.awayLogo = [UIImage imageWithData:awayImgData];
////        
////        
////        
////    }
//    return yes;
//}

@end
