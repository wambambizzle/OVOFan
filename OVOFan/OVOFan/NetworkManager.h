//
//  NetworkManager.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

// Class method to access the singleton object
+ (NetworkManager *)sharedNetworkManager;

- (void) grabTheSchedule;

@end
