//
//  Annotation.m
//  MapConnect
//
//  Created by Ruthwick Pathireddy on 7/28/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import "Annotation.h"

@interface Annotation ()
@property (nonatomic) CLLocationCoordinate2D annotationCoordinate;
@property (strong, nonatomic) NSString *annotationTitle;
@property (strong, nonatomic) NSString *annotationSubtitle;
@end

@implementation Annotation

// Designated initializer
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                             title:(NSString *)title
                          subtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        self.annotationCoordinate = coordinate;
        self.annotationTitle = title;
        self.annotationSubtitle = subtitle;
    }
    return self;
}

// Coordinate for annotation
- (CLLocationCoordinate2D)coordinate
{
    return self.annotationCoordinate;
}

// Title for annotation
- (NSString *)title
{
    return self.annotationTitle ? self.annotationTitle : nil;
}

// Subtitle for annotation
- (NSString *)subtitle
{
    return self.annotationSubtitle ? self.annotationSubtitle : nil;
}

// Returns description of an annotation
- (NSString *)description
{
    return [NSString stringWithFormat:@"Coordinate Latitude: %f\nCoordinate Longitude: %f\nTitle: %@\nSubtitle: %@\n",
            self.coordinate.latitude, self.coordinate.longitude, self.title, self.subtitle];
}

@end
