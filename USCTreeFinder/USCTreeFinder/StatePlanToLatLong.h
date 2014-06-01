//
//  StatePlanToLatLong.h
//  USCTreeFinder
//
//  Created by Dayton Pruet on 5/31/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface StatePlanToLatLong : NSObject

- (CLLocationCoordinate2D)convert:(float)xCoord YCoordinate:(float)yCoord;

@end
