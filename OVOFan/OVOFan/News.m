//
//  News.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/29/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)initWithArticleTitle:(NSString *)articleTitle articleLink:(NSURL *)articleLink articleImage:(UIImage *)articleImage
{
    self = [super init];
    if (self)
    {
        _articleTitle = articleTitle;
        _articleLink = articleLink;
        _articleImage = articleImage;
    }
    
    return self;
}

+ (instancetype)newsArticleWithDictionary:(NSDictionary *)newsDictionary dicToParse:(int)i
{
    
    News *theArticle = [[News alloc] init];

    NSDictionary *results = [newsDictionary objectForKey:@"results"];
    NSArray *recentNews = [results objectForKey:@"Recent News"];
    NSDictionary *recentNewsDict = [recentNews objectAtIndex:i];
   
    NSDictionary *imageDic = [recentNewsDict objectForKey:@"image"];
    NSURL *imgURL = [NSURL URLWithString:[imageDic objectForKey:@"src"]];
    NSData *articleImgData = [NSData dataWithContentsOfURL:imgURL];
    theArticle.articleImage = [UIImage imageWithData:articleImgData];
    
//    NSString *linkString = [recentNewsDict objectForKey:@"titleLink"];
////    NSLog(@"%@", linkString);
//    
//    theArticle.articleLink = [NSURL URLWithString:linkString];
//
//    theArticle.articleTitle = [recentNewsDict objectForKey:@"titleText"];
    
    
    
    return theArticle;
}


@end
