//
//  LeagueStandingsTableViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "LeagueStandingsTableViewController.h"
#import "LeagueStandingsCell.h"

#import "NetworkManager.h"

@interface LeagueStandingsTableViewController ()
{
    NSMutableArray *leagueArray;
    UIColor *ovoPurple;
}

@end

@implementation LeagueStandingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    leagueArray = [[NSMutableArray alloc] init];
    [NetworkManager sharedNetworkManager].leagueStandingsdelegate = self;
    [[NetworkManager sharedNetworkManager] fetchLeagueStandings];
    
    self.title = @"League Standings";
    
    ovoPurple = [UIColor colorWithRed:0.392 green:0.208 blue:0.553 alpha:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWithError:) name:@"showWithError" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return leagueArray.count + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *returnValue = @"";

    if (section == 0)
    {
        returnValue = @"Eastern Conference Standings";

        return returnValue;
    }
    
    return  nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeagueStandingHeaderCell" forIndexPath:indexPath];
            
//             cell.backgroundColor = ovoPurple;
            
            return cell;
        }
        else
        {
            LeagueStandingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeagueStandingsCell" forIndexPath:indexPath];
            
            Rankings *aRank = leagueArray[indexPath.row - 1];
            
            cell.clubName.text = aRank.clubName;
            cell.goalDiff.text = aRank.goalDiff;
            cell.points.text = aRank.pointsScored;
            cell.position.text = aRank.position;
            
            tableView.separatorColor = ovoPurple;
            
            if ([aRank.clubName isEqualToString:@"Orlando City SC"])
            {

//                 cell.backgroundColor = [UIColor lightGrayColor];
                
                cell.clubName.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:15];
                cell.goalDiff.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:15];
                cell.points.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:15];
                cell.position.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:15];
                
                cell.clubName.textColor = ovoPurple;
                cell.goalDiff.textColor = ovoPurple;
                cell.points.textColor = ovoPurple;
                cell.position.textColor = ovoPurple;
                
//                cell.clubName.textColor = [UIColor whiteColor];
//                cell.goalDiff.textColor = [UIColor whiteColor];
//                cell.points.textColor = [UIColor whiteColor];
//                cell.position.textColor = [UIColor whiteColor];
                
//                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                
            }

            return cell;
        }
    
    return nil;
}


-(void)recentStandingsWasFound:(NSMutableArray *)recentStandings
{
    leagueArray = recentStandings;
    [self.tableView reloadData];
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - NSNotificantion Center Error

-(void)showWithError:(NSNotification *)errorNotification
{
    NSError *error = [errorNotification.userInfo objectForKey:@"error"];
    
    NSString *alertTitle = [NSString stringWithFormat:@"%@", [error localizedDescription]];
    NSString *alertMessage = @"Click Retry to try again";
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:alertTitle
                                          message:alertMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         
                                                         
                                                     }];
    
    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            
                                                        [[NetworkManager sharedNetworkManager] fetchLeagueStandings];
                                                            
                                                        }];
    [alertController addAction:okAction];
    [alertController addAction:retryAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
