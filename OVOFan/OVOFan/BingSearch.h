//
//  BingSearch.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/3/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsTableViewController.h"

@interface BingSearch : NSObject

@property (strong, nonatomic)id<NewsTableViewControllerDelegate> newsdelegate;

@property (strong, nonatomic) NSURL *articleUrl;
@property (strong, nonatomic) NSString *articleTitle;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *articleDescription;
@property (strong, nonatomic) NSString *date;

//- (instancetype)initWithArticleTitle:(NSString *)articleTitle articleUrl:(NSString *)articleUrl articleDescription:(NSString *)articleDescription source:(NSString *)source AndDate:(NSString *)date;

+ (instancetype)newsArticleWithDictionary:(NSDictionary *)newsDictionary dicToParse:(int)i;

- (void)bingNewsSearch;

@end
