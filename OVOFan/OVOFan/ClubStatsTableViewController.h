//
//  ClubStatsTableViewController.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/2/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClubStatsTableViewControllerDelegate

-(void)clubStatsWasFound:(NSMutableArray *)clubStats;

@end

@interface ClubStatsTableViewController : UITableViewController <ClubStatsTableViewControllerDelegate>

@end
