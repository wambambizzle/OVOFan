//
//  NewsTableViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/29/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "NewsTableViewController.h"
#import "WebsiteViewController.h"

#import "NewsCell.h"

#import "NetworkManager.h"

@interface NewsTableViewController ()
{
    NSMutableArray *recentNewsArray;
}

@end

@implementation NewsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NetworkManager sharedNetworkManager].newsdelegate = self;
    [[NetworkManager sharedNetworkManager] fetchRecentNewsArticles];
    
    recentNewsArray = [[NSMutableArray alloc] init];
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
    return recentNewsArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    

        News *anArticle = recentNewsArray[indexPath.row];
    
        cell.articleTitle.text = anArticle.articleTitle;
        
        cell.articleImage.image = anArticle.articleImage;
    
          [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    return cell;
}

-(void)recentNewsWasFound:(NSMutableArray *)recentNews
{
    recentNewsArray = recentNews;
    [self.tableView reloadData];

}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    News *anArticle = [recentNewsArray objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebsiteViewController *websiteVC = [storyboard instantiateViewControllerWithIdentifier:@"WebsiteVC"];
    websiteVC.anArticle = anArticle;
   
    [self showViewController:websiteVC sender:nil];
        
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
