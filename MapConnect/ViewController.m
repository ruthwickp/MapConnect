//
//  ViewController.m
//  MapConnect
//
//  Created by Ruthwick Pathireddy on 7/27/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
// Outlet to mapView
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Sets mapview to track current user location whenever view appears
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}

- (IBAction)drawPathForAnnotations
{
}
- (IBAction)drawPolygonForAnnotations
{
}
- (IBAction)clearAll
{
}

@end
