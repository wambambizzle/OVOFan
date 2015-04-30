//
//  LeagueStandingsCell.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeagueStandingsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *clubName;
@property (strong, nonatomic) IBOutlet UILabel *goalDiff;
@property (strong, nonatomic) IBOutlet UILabel *points;
@property (strong, nonatomic) IBOutlet UILabel *position;

@end
