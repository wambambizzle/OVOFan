//
//  AttendanceCell.h
//  OVOFan
//
//  Created by Jordan Anderson on 5/4/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *aggregatedAttendance;
@property (strong, nonatomic) IBOutlet UILabel *averageAttendance;
@property (strong, nonatomic) IBOutlet UILabel *largestAttendance;

@end
