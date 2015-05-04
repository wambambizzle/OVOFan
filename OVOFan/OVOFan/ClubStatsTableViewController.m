//
//  ClubStatsTableViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 5/2/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "ClubStatsTableViewController.h"

#import "AssistCell.h"
#import "AttendanceCell.h"
#import "GoalCell.h"

#import "NetworkManager.h"

@interface ClubStatsTableViewController ()
{
    NSArray *goalsArray;
    NSArray *assitsArray;
    NSArray *attendanceArray;
    NSMutableArray *clubStatsArray;
}

@end

@implementation ClubStatsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NetworkManager sharedNetworkManager] fetchClubStats];
    [NetworkManager sharedNetworkManager].clubStatsdelegate = self;
    
    clubStatsArray = [[NSMutableArray alloc] init];
    goalsArray = [[NSArray alloc] init];
    assitsArray = [[NSArray alloc] init];
    attendanceArray = [[NSArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return clubStatsArray.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return goalsArray.count;
    }
    
    else if (section == 1)
    {
        return assitsArray.count;
    }
    else
    {
        return attendanceArray.count;
    }
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSArray *titlesArray = @[@"Score Leader", @"Assist Leader", @"Attendance"];
//    
// 
//    return titlesArray;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section == 0)
    {
        Goals *goalStat = goalsArray[indexPath.row];
        GoalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalsCell" forIndexPath:indexPath];
        cell.goal.text = goalStat.goals;
        cell.player.text = goalStat.player;
        cell.rank.text = goalStat.rank;
        
        return cell;
        
    }
    else if (indexPath.section == 1)
    {
        Assists *assistStat = assitsArray[indexPath.row];
        AssistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssistsCell" forIndexPath:indexPath];
        cell.assists.text = assistStat.assist;
        cell.player.text = assistStat.player;
        cell.rank.text = assistStat.rank;
        
        return cell;
    }
    else
    {
        Attendance *attendanceStat = attendanceArray[indexPath.row];
        AttendanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttendanceCell" forIndexPath:indexPath];
       
        cell.aggregatedAttendance.text = attendanceStat.aggregatedAttendance;
        cell.averageAttendance.text = attendanceStat.averageAttendance;
        cell.largestAttendance.text = attendanceStat.largestAttendance;
       
        return cell;
    }

    
}

-(void)clubStatsWasFound:(NSMutableArray *)clubStats
{
    clubStatsArray = clubStats;
    attendanceArray = clubStats[0];
    assitsArray = clubStats[1];
    goalsArray = clubStats[2];

    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
