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

#import "UpcomingMatch.h"
#import "NetworkManager.h"

@interface HomeViewController () <UIPopoverPresentationControllerDelegate>

- (IBAction)scheduleTapped:(UIButton *)sender;
- (IBAction)shuttleMapTapped:(UIButton *)sender;
- (IBAction)recentNewsTapped:(UIButton *)sender;
- (IBAction)leagueStandingsTapped:(UIButton *)sender;
- (IBAction)teamTapped:(UIButton *)sender;

- (IBAction)statsTapped:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *soccerButton;

@property (strong, nonatomic) IBOutlet UIButton *scheduleLabel;
@property (strong, nonatomic) IBOutlet UIButton *newsLabel;
@property (strong, nonatomic) IBOutlet UIButton *statsLabel;
@property (strong, nonatomic) IBOutlet UIButton *shuttleLabel;
@property (strong, nonatomic) IBOutlet UIButton *leagueLabel;
@property (strong, nonatomic) IBOutlet UIButton *teamLabel;


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

- (IBAction)scheduleTapped:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"ShowScheduleSegue" sender:self];
}

- (IBAction)shuttleMapTapped:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"ShowShuttleMapSegue" sender:self];
}

- (IBAction)recentNewsTapped:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"ShowNewsSegue" sender:self];
}

- (IBAction)leagueStandingsTapped:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"ShowLeagueStandingSegue" sender:self];
}

- (IBAction)teamTapped:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"ShowTeamSegue" sender:self];
}

- (IBAction)statsTapped:(UIButton *)sender
{
        [self performSegueWithIdentifier:@"ShowStatsSegue" sender:self];
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
        UpcomingGameViewController *upcomingGameVC = (UpcomingGameViewController *)[segue destinationViewController];

        upcomingGameVC.popoverPresentationController.delegate = self;
        upcomingGameVC.preferredContentSize = CGSizeMake(250.0f, 200.0f);
        
//        upcomingGameVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
//        upcomingGameVC.popoverPresentationController.sourceView = [upcomingGameVC view];
//        upcomingGameVC.popoverPresentationController.sourceRect = CGRectMake(100, 100, 0, 0);
        

    }

}

#pragma mark - PopoverPresentationController delegate

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone; // tells the presentation style for the modal when shown
}



@end
