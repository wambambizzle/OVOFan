//
//  NewsTableViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/29/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "NewsTableViewController.h"
#import "WebsiteViewController.h"

#import "BingSearch.h"

#import "NewsCell.h"

#import <JGProgressHUD/JGProgressHUD.h>


@interface NewsTableViewController ()
{
    NSMutableArray *recentNewsArray;
    BingSearch *_aSearch;
    JGProgressHUD *HUD;
}

@end

@implementation NewsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _aSearch = [[BingSearch alloc] init];
    [_aSearch bingNewsSearch];
    
    _aSearch.newsdelegate = self;
    
    recentNewsArray = [[NSMutableArray alloc] init];
    
    self.title = @"News";
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents: UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    [self JGShowLoadingHud];
    
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
    return recentNewsArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsArticleCell" forIndexPath:indexPath];
    
        BingSearch *anArticle = recentNewsArray[indexPath.row];
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:anArticle.articleTitle];
    [attributedString addAttribute:NSKernAttributeName
                             value:[NSNumber numberWithFloat:0.4]
                             range:NSMakeRange(0, [anArticle.articleTitle length])];

//    [self.label setAttributedText:attributedString];
    
        cell.articleTitle.attributedText = attributedString;
        cell.articleDescription.text = anArticle.articleDescription;
        cell.source.text = anArticle.source;
//        cell.date.text = anArticle.date;
    
//    NSLog(@"%@", cell.articleTitle.text);
//    NSLog(@"%@", cell.articleDescription.text);
    
    return cell;
}

-(void)recentNewsWasFound:(NSMutableArray *)recentNews
{
   recentNewsArray = recentNews;
   [self.tableView reloadData];
    [HUD dismissAnimated:YES];

}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BingSearch *anArticle = [recentNewsArray objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebsiteViewController *websiteVC = [storyboard instantiateViewControllerWithIdentifier:@"WebsiteVC"];
    websiteVC.anArticle = anArticle;
   
    [self showViewController:websiteVC sender:nil];
        
}

#pragma mark - UITableView UIRefresh

- (void)refreshView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Fresh News Incoming"];
    
    [_aSearch bingNewsSearch];
    
    [refresh endRefreshing];
    
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
                                                        
                                                        [_aSearch bingNewsSearch];
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
