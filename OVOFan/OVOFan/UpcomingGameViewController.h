//
//  UpcomingGameViewController.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpcomingMatch.h"

@protocol UpcomingGameViewControllerDelegate

-(void)nextMatchWasFound:(UpcomingMatch *)nextMatch;

@end

@interface UpcomingGameViewController : UIViewController <UpcomingGameViewControllerDelegate>

@end
