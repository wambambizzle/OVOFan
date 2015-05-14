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

#define MAP_DISPLAY_SCALE 1.5 *1609.344

@interface ShuttleMapViewController () <CLLocationManagerDelegate, MKAnnotation, MKOverlay>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    
    UIColor *ovoPurple;
    

}
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSMutableArray *allRouteCoords;
@property (nonatomic, strong) MKPolyline *polyline;

@end

@implementation ShuttleMapViewController
@synthesize boundingMapRect;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ovoPurple = [UIColor colorWithRed:0.392 green:0.208 blue:0.553 alpha:1];
    
    
    [self configureMapView];
    [self configureAndDropPins];
    [self configureLocationManager];
    
//    [self drawLineRoute];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"HelveticaNeue-Light" size:20],
      NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    self.title = @"Shuttle Map";
    self.navigationItem.prompt = @"Citrus Bowl Connection";
    
//    28.541944, -81.382936   28.538447, -81.383096
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Map Configuration

- (void)configureMapView
{
    self.coordinate = CLLocationCoordinate2DMake(28.541974, -81.390542);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.coordinate, MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion];
}

- (void)configureAndDropPins
{
    // first annotation
    CLLocationCoordinate2D churchAndNortonAve = CLLocationCoordinate2DMake(28.540197, -81.398224);
    MKPointAnnotation *churchAndNortonAveAnnotation = [[MKPointAnnotation alloc] init];
    [churchAndNortonAveAnnotation setCoordinate:churchAndNortonAve];
    [churchAndNortonAveAnnotation setTitle:@"Stadium Drop Off"]; //You can set the subtitle too

    // second annotation
    CLLocationCoordinate2D centralAndHugheyAve = CLLocationCoordinate2DMake(28.541809, -81.382964);
    MKPointAnnotation *centralAndHugheyAveAnnotation = [[MKPointAnnotation alloc] init];
    [centralAndHugheyAveAnnotation setCoordinate:centralAndHugheyAve];
    [centralAndHugheyAveAnnotation setTitle:@"Pick Up"];
    
    // third annotation
    CLLocationCoordinate2D southAndDivisionAve = CLLocationCoordinate2DMake(28.538378, -81.384842);
    MKPointAnnotation *southAndDivisionAveAnnotation = [[MKPointAnnotation alloc] init];
    [southAndDivisionAveAnnotation setCoordinate:southAndDivisionAve];
    [southAndDivisionAveAnnotation setTitle:@"Pick Up"];
    
    NSMutableArray *shuttleAnnotationsArray = [[NSMutableArray alloc] initWithObjects:churchAndNortonAveAnnotation, centralAndHugheyAveAnnotation, southAndDivisionAveAnnotation, nil];
  
    [self.mapView addAnnotations:shuttleAnnotationsArray];
    
}

#pragma mark - MK Overlay Path

//    CLLocationCoordinate2D purplePoints[2];
//    purplePoints[0] = CLLocationCoordinate2DMake(28.541944, -81.382936);
//    purplePoints[1] = CLLocationCoordinate2DMake(28.538447, -81.383096);

//MKPolylineRenderer


    
- (void)drawLineRoute
{
        CLLocationCoordinate2D purplePoints[2];
        purplePoints[0] = CLLocationCoordinate2DMake(28.541944, -81.382936);
        purplePoints[1] = CLLocationCoordinate2DMake(28.538447, -81.383096);
    
    self.polyline = [MKPolyline polylineWithCoordinates:purplePoints count:2];
    self.polyline.title = @"Citrus Bowl Connection";
    
    [self.mapView addOverlay:self.polyline];
}

#pragma mark - Location Manager

- (void)configureLocationManager
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
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
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

- (void)enableLocationManager:(BOOL)enable
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
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    CLLocation *loca = [locations lastObject];
        self.mapView.showsUserLocation = YES;
    
    
    [self enableLocationManager:NO];
    
//    self.aLocation = [[Location alloc] initWithCoordinate:loca.coordinate pinDescription:self.aLocation.name];
//    [self configureMapView];
    
    
//    [self.pinCurrentItem setEnabled:YES];
    
    
    
}

@end
