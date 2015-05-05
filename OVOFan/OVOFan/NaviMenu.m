//
//  NaviMenu.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/5/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "NaviMenu.h"

@implementation NaviMenu

- (instancetype)initWithNavLabel:(NSString *)navLabel navImage:(UIImage *)navImage
{
        self = [super init];
        if (self)
        {
            _navLabel = navLabel;
            _navImage = navImage;
        }
    
        return self;
}

@end

