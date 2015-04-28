//
//  ViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/27/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "HomeViewController.h"
#import "StadiumMapViewController.h"

#import "NetworkManager.h"

@interface HomeViewController () <UIPopoverPresentationControllerDelegate>

- (IBAction)scheduleTapped:(id)sender;
- (IBAction)showStadiumMapTapp:(id)sender;

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

- (IBAction)showStadiumMapTapp:(id)sender
{
    [self performSegueWithIdentifier:@"ShowStadiumMapSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowStadiumMapSegue"])
    {
        StadiumMapViewController *desPopupCalcVC = (StadiumMapViewController *)[segue destinationViewController];
        desPopupCalcVC.popoverPresentationController.delegate = self; // must set our "self" as a delegate of
        //    popUpVC.recieveAllEnergyTypes = allEnergyTypes;
        //        NSLog(@"%@", popUpVC.recieveAllEnergyTypes);
        // Calls our class method from PowerCalc and sets it in an Array
//        float contentHeight = 44.0f; // set the height of the modal to 44px * number of items in array
        desPopupCalcVC.preferredContentSize = CGSizeMake(310.0f, 415.0f); // giving a size to the pop over view width and height
    }
    
}

#pragma mark - PopoverPresentationController delegate

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone; // tells the presentation style for the modal when shown
}

@end
