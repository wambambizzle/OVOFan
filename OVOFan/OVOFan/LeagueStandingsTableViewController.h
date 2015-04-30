//
//  LeagueStandingsTableViewController.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Rankings.h"

@protocol LeagueStandingTableViewControllerDelegate

-(void)recentStandingsWasFound:(NSMutableArray *)recentStandings;

@end

@interface LeagueStandingsTableViewController : UITableViewController <LeagueStandingTableViewControllerDelegate>

@end
