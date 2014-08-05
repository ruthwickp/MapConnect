//
//  MapViewController.m
//  MapConnect
//
//  Created by Ruthwick Pathireddy on 7/27/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"

@interface MapViewController () <MKMapViewDelegate>
// Outlet to mapView
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLGeocoder *geocoder;
@end

@implementation MapViewController

#pragma mark - Setters and Getters

// Lazy instantiation
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

#pragma mark - View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Sets mapview to track current user location whenever view appears
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}

// Sets ourself to contain the mapView delegate
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
}

#pragma mark - Button presses

- (IBAction)drawPathForAnnotations
{
}
- (IBAction)drawPolygonForAnnotations
{
}
- (IBAction)clearAll
{
}

#pragma mark - Map User Interface

// When user taps a location in mapView, an annotation is added
// to the map
- (IBAction)tappedLocationInMapView:(UITapGestureRecognizer *)sender
{
    CGPoint tappedLocation = [sender locationInView:self.mapView];
    [self drawAnnotationAtLocation:tappedLocation];
}

// Draws annotation at the location in mapview
- (void)drawAnnotationAtLocation:(CGPoint)point
{
    CLLocationCoordinate2D pointInMap = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    // Reverse geocode location geocoded location as title of annotation
    CLLocation *location = [[CLLocation alloc] initWithLatitude:pointInMap.latitude longitude:pointInMap.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            Annotation *annotation = [[Annotation alloc] initWithCoordinate:pointInMap
                                                                      title:[[placemarks firstObject] name]
                                                                   subtitle:[[placemarks firstObject] country]];
            [self.mapView addAnnotation:annotation];
        }
    }];
}

// Only shows visible annotations
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString *identifier = @"AnnotationView";
    // Reuses annotation views
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        [view setCanShowCallout:YES];
    }
    view.annotation = annotation;
    return view;
}

@end
