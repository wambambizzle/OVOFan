//
//  TeamTableViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/30/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "TeamTableViewController.h"
#import "PlayerWebViewController.h"

#import "TeamCell.h"

#import "NetworkManager.h"

@interface TeamTableViewController ()
{
    NSMutableArray *teamMemArray;
}

@end

@implementation TeamTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NetworkManager sharedNetworkManager] fetchCurrentTeam];
    [NetworkManager sharedNetworkManager].teamdelegate = self;
    teamMemArray = [[NSMutableArray alloc] init];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return teamMemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell" forIndexPath:indexPath];
    
    Team *aPlayer = teamMemArray[indexPath.row];
    
    cell.playerImage.image = aPlayer.playerImage;
    cell.name.text = aPlayer.name;
    cell.number.text = aPlayer.number;
    cell.position.text = aPlayer.position;
    cell.weight.text = aPlayer.weight;
    cell.height.text = aPlayer.height;
    cell.age.text = aPlayer.age;
    
    return cell;
}


-(void)teamMembersWereFound:(NSMutableArray *)team
{
    teamMemArray = team;
    [self.tableView reloadData];
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Team *aPlayer = [teamMemArray objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PlayerWebViewController *playerWebsiteVC = [storyboard instantiateViewControllerWithIdentifier:@"PlayerWebVC"];
    playerWebsiteVC.aPlayer = aPlayer;
   
    [self showViewController:playerWebsiteVC sender:nil];
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
