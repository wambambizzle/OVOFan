//
//  NaviMenu.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/5/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NaviMenu : NSObject

@property (strong, nonatomic) NSString *navLabel;
@property (strong, nonatomic) UIImage *navImage;


- (instancetype)initWithNavLabel:(NSString *)navLabel navImage:(UIImage *)navImage;

@end
