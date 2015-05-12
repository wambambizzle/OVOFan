//
//  UpcomingGameViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "UpcomingGameViewController.h"
#import "NetworkManager.h"

#import "UpcomingMatch.h"



@interface UpcomingGameViewController ()
{
    NSMutableArray *matchesArray;
    UpcomingMatch *theMatch;
}

@property (weak, nonatomic) IBOutlet UIImageView *homeIconImage;
@property (weak, nonatomic) IBOutlet UIImageView *awayIconImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation UpcomingGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     [NetworkManager sharedNetworkManager].delegate = self;
    [[NetworkManager sharedNetworkManager] fetchTheUpcomingMatch];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWithError:) name:@"showWithError" object:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextMatchWasFound:(UpcomingMatch *)nextMatch
{
//    NSLog(@"%@", nextMatch);
    self.dateLabel.text = nextMatch.date;
    self.locationLabel.text = nextMatch.location;
    self.timeLabel.text = nextMatch.time;
    self.homeIconImage.image = nextMatch.homeLogo;
    self.awayIconImage.image = nextMatch.awayLogo;
    
//    theMatch = nextMatch;
    
   
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
                                                            
                                                        [[NetworkManager sharedNetworkManager] fetchTheUpcomingMatch];
                                                            
                                                        }];
    [alertController addAction:okAction];
    [alertController addAction:retryAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
