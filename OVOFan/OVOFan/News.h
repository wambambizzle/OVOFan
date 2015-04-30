//
//  News.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/29/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface News : NSObject

@property (strong, nonatomic) NSURL *articleLink;
@property (strong, nonatomic) NSString *articleTitle;
@property (strong, nonatomic) UIImage *articleImage;


- (instancetype)initWithArticleTitle:(NSString *)articleTitle articleLink:(NSURL *)articleLink articleImage:(UIImage *)articleImage;

+ (instancetype)newsArticleWithDictionary:(NSDictionary *)newsDictionary dicToParse:(int)i;

@end
