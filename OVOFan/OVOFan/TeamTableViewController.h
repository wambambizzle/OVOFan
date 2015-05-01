//
//  TeamTableViewController.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Team.h"

@protocol TeamTableViewControllerDelegate

-(void)teamMembersWereFound:(NSMutableArray *)team;

@end

@interface TeamTableViewController : UITableViewController <TeamTableViewControllerDelegate>

@end
