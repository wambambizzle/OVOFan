//
//  NetworkManager.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NewsTableViewController.h"
#import "UpcomingGameViewController.h"
#import "LeagueStandingsTableViewController.h"
#import "TeamTableViewController.h"

#import "News.h"
#import "UpcomingMatch.h"
#import "Rankings.h"
#import "Team.h"

@interface NetworkManager : NSObject

@property (strong, nonatomic)id<LeagueStandingTableViewControllerDelegate> leagueStandingsdelegate;
@property (strong, nonatomic)id<NewsTableViewControllerDelegate> newsdelegate;
@property (strong, nonatomic)id<TeamTableViewControllerDelegate> teamdelegate;
@property (strong, nonatomic)id<UpcomingGameViewControllerDelegate> delegate;

// Class method to access the singleton object
+ (NetworkManager *)sharedNetworkManager;

- (void)fetchTheSchedule;
- (void)fetchTheUpcomingMatch;
- (void)fetchRecentNewsArticles;
- (void)fetchLeagueStandings;
- (void)fetchCurrentTeam;

@end
