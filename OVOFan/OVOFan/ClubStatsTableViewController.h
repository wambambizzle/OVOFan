//
//  ClubStatsTableViewController.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/2/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClubStatsTableViewControllerDelegate

-(void)clubStatsGoalsWasFound:(NSMutableArray *)stats;

-(void)clubStatsAssistsWasFound:(NSMutableArray *)stats;

-(void)clubStatsAttendanceWasFound:(NSMutableArray *)stats;

@end

@interface ClubStatsTableViewController : UITableViewController <ClubStatsTableViewControllerDelegate>

@end
