//
//  ViewController.m
//  MapConnect
//
//  Created by Ruthwick Pathireddy on 7/27/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"

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

// Sets ourself to contain the mapView delegate
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
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
    Annotation *annotation = [[Annotation alloc] initWithCoordinate:pointInMap
                                                                            title:nil
                                                                         subtitle:nil];
    [self.mapView addAnnotation:annotation];
}

@end
