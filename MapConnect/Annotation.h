//
//  Annotation.h
//  MapConnect
//
//  Created by Ruthwick Pathireddy on 7/28/14.
//  Copyright (c) 2014 Darkking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

// Designated initializer
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                             title:(NSString *)title
                          subtitle:(NSString *)subtitle;

// Override description
- (NSString *)description;


@end
