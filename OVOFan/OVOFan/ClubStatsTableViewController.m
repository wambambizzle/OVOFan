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

typedef enum
{
    StatsSectionGoals = 0,
    StatsSectionAssist = 1,
    StatsSectionAttendance = 2
} StatsSection;

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
    if (section == StatsSectionGoals)
    {
        return goalsArray.count + 1;
    }
    
    else if (section == StatsSectionAssist)
    {
        return assitsArray.count + 1;
    }
    else 
    {
        return attendanceArray.count + 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *returnValue = @"";
    if (section == StatsSectionGoals)
        returnValue = @"Scoring Leaders";
    else if (section == StatsSectionAssist)
        returnValue = @"Assists Leaders";
    else if (section == StatsSectionAttendance)
        returnValue = @"Game Attendance";
    return returnValue;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == StatsSectionGoals)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalsHeaderCell" forIndexPath:indexPath];
            
            return cell;
        }
        else
        {
            Goals *goalStat = goalsArray[indexPath.row - 1];
            GoalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalsCell" forIndexPath:indexPath];
            cell.goal.text = goalStat.goals;
            cell.player.text = goalStat.player;
            cell.rank.text = goalStat.rank;
            
            return cell;
        }
        
    }
    else if (indexPath.section == StatsSectionAssist)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssistHeaderCell" forIndexPath:indexPath];
            
            return cell;
        }
        
        else
        {
            Assists *assistStat = assitsArray[indexPath.row - 1];
            AssistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssistsCell" forIndexPath:indexPath];
            cell.assists.text = assistStat.assist;
            cell.player.text = assistStat.player;
            cell.rank.text = assistStat.rank;
            
            return cell;
        }
        
    }
    else // if (indexPath.section == StatsSectionAttendance)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttendanceHeaderCell" forIndexPath:indexPath];
            
            return cell;
        }
        else
        {
            Attendance *attendanceStat = attendanceArray[indexPath.row - 1];
            AttendanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttendanceCell" forIndexPath:indexPath];
            cell.aggregatedAttendance.text = attendanceStat.aggregatedAttendance;
            cell.averageAttendance.text = attendanceStat.averageAttendance;
            cell.largestAttendance.text = attendanceStat.largestAttendance;
            
            return cell;
        }
        
    }
    
//    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom Delegate

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
