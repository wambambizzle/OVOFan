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

@interface ShuttleMapViewController () <CLLocationManagerDelegate, MKAnnotation, MKOverlay, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    
    UIColor *ovoPurple;
    

}
@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ShuttleMapViewController
@synthesize boundingMapRect;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ovoPurple = [UIColor colorWithRed:0.392 green:0.208 blue:0.553 alpha:1];
    self.mapView.delegate = self;

    [self configureMapView];
    [self configureAndDropPins];
    [self configureLocationManager];
    
    [self drawLineRoute];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"HelveticaNeue-Light" size:20],
      NSFontAttributeName,
      [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    self.title = @"Shuttle Map";
    self.navigationItem.prompt = @"Citrus Bowl Connection";
    

    
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

//citrus bowl 28.540037, -81.403691   28.540065, -81.401824   28.537916, -81.401781  28.537859, -81.403691

//    CLLocationCoordinate2D citrusBowlPts[4];
//    citrusBowlPts[0] = CLLocationCoordinate2DMake(28.540037, -81.403691);
//    citrusBowlPts[1] = CLLocationCoordinate2DMake(28.540065, -81.401824);
//    citrusBowlPts[2] = CLLocationCoordinate2DMake(28.537916, -81.401781);
//    citrusBowlPts[3] = CLLocationCoordinate2DMake(28.537859, -81.403691);


- (void)drawLineRoute
{
        CLLocationCoordinate2D purplePoints[6];
        purplePoints[0] = CLLocationCoordinate2DMake(28.541988, -81.393155); //central and wesmore
        purplePoints[1] = CLLocationCoordinate2DMake(28.541980, -81.397242);
        purplePoints[2] = CLLocationCoordinate2DMake(28.541978, -81.398302);
        purplePoints[3] = CLLocationCoordinate2DMake(28.540180, -81.398287); //church and norton
        purplePoints[4] = CLLocationCoordinate2DMake(28.540153, -81.397239);
        purplePoints[5] = CLLocationCoordinate2DMake(28.540127, -81.393152);
        MKPolyline *purplePolyline = [MKPolyline polylineWithCoordinates:purplePoints count:6];
        purplePolyline.title = @"Citrus Bowl Connection";
    
    [self.mapView addOverlay:purplePolyline];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer *polyRender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        polyRender.lineWidth = 2;
        polyRender.strokeColor = ovoPurple;
        return polyRender;
    }
    
    return nil;
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
