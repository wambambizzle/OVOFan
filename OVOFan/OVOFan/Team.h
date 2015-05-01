//
//  Team.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Team : NSObject

@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) UIImage *playerImage;


- (instancetype)initWithPlayerImage:(UIImage *)playerImage age:(NSString *)age height:(NSString *)height name:(NSString *)name position:(NSString *)position number:(NSString *)number AndWeight:(NSString *)weight;

+ (instancetype)teamWithDictionary:(NSDictionary *)aDictionary dicToParse:(int)i;

@end
