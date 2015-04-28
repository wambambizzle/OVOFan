//
//  ViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "HomeViewController.h"
#import "StadiumMapViewController.h"
#import "UpcomingGameViewController.h"

#import "NetworkManager.h"

@interface HomeViewController () <UIPopoverPresentationControllerDelegate>

- (IBAction)scheduleTapped:(id)sender;
- (IBAction)showStadiumMapTapped:(UIBarButtonItem *)sender;
- (IBAction)showUpcomingGameTapped:(UIBarButtonItem *)sender;


@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Orlando's Very Own";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scheduleTapped:(id)sender
{
    [[NetworkManager sharedNetworkManager] grabTheSchedule];
    [self performSegueWithIdentifier:@"ShowScheduleSegue" sender:self];
    
    
}

- (IBAction)showStadiumMapTapped:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"ShowStadiumMapSegue" sender:self];
}

- (IBAction)showUpcomingGameTapped:(UIBarButtonItem *)sender
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowStadiumMapSegue"])
    {
        StadiumMapViewController *stadiumMapVC = (StadiumMapViewController *)[segue destinationViewController];
        stadiumMapVC.popoverPresentationController.delegate = self; // must set our "self" as a
        stadiumMapVC.preferredContentSize = CGSizeMake(310.0f, 415.0f); // giving a size to the pop over view width and height
    }
    else if ([segue.identifier isEqualToString:@"ShowUpcomingGameSegue"])
    {
//            [[NetworkManager sharedNetworkManager] grabTheSchedule];
        UpcomingGameViewController *upcomingGameVC = (UpcomingGameViewController *)[segue destinationViewController];
        upcomingGameVC.popoverPresentationController.delegate = self;
        upcomingGameVC.preferredContentSize = CGSizeMake(250.0f, 250.0f);

    }
    
}

#pragma mark - PopoverPresentationController delegate

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone; // tells the presentation style for the modal when shown
}

@end
