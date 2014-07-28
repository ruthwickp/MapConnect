//
//  mapViewAnnotation.m
//  MapConnect
//
//  Created by Ruthwick Pathireddy on 7/28/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "mapViewAnnotation.h"

@interface mapViewAnnotation ()
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite, copy) NSString *title;
@property (nonatomic, readwrite, copy) NSString *subtitle;

@end

@implementation mapViewAnnotation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                             title:(NSString *)title
                          subtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Coordinate Latitude: %f\nCoordinate Longitude: %f\nTitle: %@\nSubtitle: %@\n",
            self.coordinate.latitude, self.coordinate.longitude, self.title, self.subtitle];
}

@end
