//
//  GoalCell.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *goal;
@property (strong, nonatomic) IBOutlet UILabel *player;
@property (strong, nonatomic) IBOutlet UILabel *rank;

@end
