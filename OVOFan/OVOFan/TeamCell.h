//
//  TeamCell.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *firstName;
@property (strong, nonatomic) IBOutlet UILabel *lastName;
@property (strong, nonatomic) IBOutlet UILabel *ageWeightHeight;
@property (strong, nonatomic) IBOutlet UILabel *numbAndPosition;

@property (strong, nonatomic) IBOutlet UIImageView *playerImage;

@end
