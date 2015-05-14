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

#import <JGProgressHUD/JGProgressHUD.h>

@interface TeamTableViewController ()
{
    NSMutableArray *teamMemArray;
    JGProgressHUD *HUD;
}

@end

@implementation TeamTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NetworkManager sharedNetworkManager] fetchCurrentTeam];
    [NetworkManager sharedNetworkManager].teamdelegate = self;
    teamMemArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWithError:) name:@"showWithError" object:nil];
   
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"HelveticaNeue-Light" size:20],
      NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    self.title = @"Team";
    
    [self JGShowLoadingHud];
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
    cell.playerImage.layer.cornerRadius = cell.playerImage.frame.size.height / 2;
    cell.playerImage.layer.masksToBounds = YES;
    cell.playerImage.layer.borderWidth = 4.5f;

    cell.playerImage.layer.borderColor = [UIColor colorWithRed:0.392 green:0.208 blue:0.553 alpha:1].CGColor;
   
    NSArray *nameParts = [aPlayer.name componentsSeparatedByString:@" "];
    if (![aPlayer.name containsString:@" "])
    {
        NSString *lastName = nameParts[0];
        cell.lastName.text = lastName;
        cell.firstName.text = @"";
    }
    else if (nameParts.count == 2)
    {
        NSString *firstName = nameParts[0];
        NSString *lastName = nameParts[1];
        cell.firstName.text = firstName;
        cell.lastName.text = lastName;
    }
    else if (nameParts.count == 3)
    {
        NSString *firstName = nameParts[0];
        NSString *lastName = [NSString stringWithFormat:@"%@ %@", nameParts[1], nameParts[2]];
        cell.firstName.text = firstName;
        cell.lastName.text = lastName;
    }

    cell.lastName.textColor = [UIColor colorWithRed:0.392 green:0.208 blue:0.553 alpha:1];
    
    cell.ageWeightHeight.text = [NSString stringWithFormat:@"Age %@ | Ht. %@ | Wt. %@", aPlayer.age, aPlayer.height, aPlayer.weight];
    cell.numbAndPosition.text = [NSString stringWithFormat:@"%@ | %@", aPlayer.number, aPlayer.position];
    
    
    return cell;
}


-(void)teamMembersWereFound:(NSMutableArray *)team
{
    teamMemArray = team;
    [self.tableView reloadData];
    [HUD dismissAnimated:YES];
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

#pragma mark - NSNotificantion Center Error

-(void)showWithError:(NSNotification *)errorNotification
{
    [HUD dismissAnimated:YES];
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
                                                            
                                                        [[NetworkManager sharedNetworkManager] fetchCurrentTeam];
                                                        [self JGShowLoadingHud];
                                                        }];
    [alertController addAction:okAction];
    [alertController addAction:retryAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - JG HUD Progress Method

- (void)JGShowLoadingHud
{
    HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.textLabel.text = @"Loading";
    
    [HUD showInView:self.view];
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
