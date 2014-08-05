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

// Draws a MKPolyline overlay connecting annotations
- (IBAction)drawPathForAnnotations
{
    // Gets a list of visible coordinates and creates a polyline overlay
    CLLocationCoordinate2D *coordinates = nil;
    int annotationsCount = [self getVisibleAnnotationCoordinates:&coordinates];
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:annotationsCount];
    free(coordinates);
    [self.mapView addOverlay:polyline];
}

// Delegate method to draw overlays before being displayed
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    // Customizes polyline overlays
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *polyLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        polyLineRenderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:.5];
        return polyLineRenderer;
    }
    // Customizes polygon overlays
    else if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonRenderer *polygonRenderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
        polygonRenderer.lineWidth = .5;
        polygonRenderer.strokeColor = [UIColor blackColor];
        polygonRenderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:.5];
        return polygonRenderer;
    }
    return nil;
}

// Draw a polygon connecting the visible annotations
- (IBAction)drawPolygonForAnnotations
{
    // Gets a list of visible coordinates and creates a polygon overlay
    CLLocationCoordinate2D *coordinates = nil;
    int annotationsCount = [self getVisibleAnnotationCoordinates:&coordinates];
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coordinates count:annotationsCount];
    free(coordinates);
    [self.mapView addOverlay:polygon];
}

// Fills coordinates array with coordinates of visible annotations
// and returns number of elements in array
- (int)getVisibleAnnotationCoordinates:(CLLocationCoordinate2D **)coordinates
{
    // Gets all annotations that are visible
    MKMapRect rectangle = self.mapView.visibleMapRect;
    NSSet *visibleAnnotations = [self.mapView annotationsInMapRect:rectangle];
    
    // Stores coordinates in array
    *coordinates = malloc(sizeof(CLLocationCoordinate2D) * [visibleAnnotations count]);
    int index = 0;
    for (id obj in visibleAnnotations) {
        if ([obj isKindOfClass:[Annotation class]]) {
            (*coordinates)[index] = ((Annotation *)obj).coordinate;
            index++;
        }
    }
    
    return index;
}

// Clears all overlays and annotations
- (IBAction)clearAll
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
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

@end
