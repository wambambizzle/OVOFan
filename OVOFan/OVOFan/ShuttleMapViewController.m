//
//  ShuttleMapViewController.m
//  OVOFan
//
//  Created by Jordan Anderson on 4/28/15.
//  Copyright (c) 2015 Jordan Anderson. All rights reserved.
//

#import "ShuttleMapViewController.h"

@import CoreLocation;
@import MapKit;

#define MAP_DISPLAY_SCALE 1.1 *1609.344

@interface ShuttleMapViewController () <CLLocationManagerDelegate, MKAnnotation>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;


}
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ShuttleMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureMapView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureMapView
{

    self.coordinate = CLLocationCoordinate2DMake(28.541016, -81.381289);
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.coordinate, MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion];
    
}

//-(void)configurePin
//{
//    [self.mapView addAnnotation:];
//}
//
//-(void)dropPin
//{
//    [self.mapView addAnnotation:];
//}

-(void)configureLocationManager
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!locationManager)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
    }
    else
    {
//        [self.pinCurrentItem setEnabled:NO];
    }
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
//        [self.pinCurrentItem setEnabled:NO];
    }
    else
    {
        [self enableLocationManager:YES];
    }
}

-(void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable)
        {
            [locationManager stopUpdatingLocation];
            [locationManager startUpdatingLocation];
        }
        else
        {
            [locationManager stopUpdatingLocation];
        }
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loca = [locations lastObject];
    
    
    [self enableLocationManager:NO];
    
//    self.aLocation = [[Location alloc] initWithCoordinate:loca.coordinate pinDescription:self.aLocation.name];
    [self configureMapView];
    
    
//    [self.pinCurrentItem setEnabled:YES];
    
    
    
}

@end
