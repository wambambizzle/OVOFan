//
//  NewsTableViewController.h
//  OVOFan
//
//  Created by Jordan Anderson on 4/29/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BingSearch.h"

@protocol NewsTableViewControllerDelegate 

-(void)recentNewsWasFound:(NSMutableArray *)recentNews;

@end

@interface NewsTableViewController : UITableViewController <NewsTableViewControllerDelegate>

@end
