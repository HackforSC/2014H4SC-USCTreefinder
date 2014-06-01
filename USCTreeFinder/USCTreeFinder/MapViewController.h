//
//  MapViewController.h
//  USCTreeFinder
//
//  Created by Dayton Pruet on 6/1/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344


@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) NSMutableArray *trees;
@property (strong,nonatomic) NSDictionary *tree;

@property (strong, nonatomic) NSMutableArray *annPinArray;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

@property (nonatomic) float XCoord;
@property (nonatomic) float YCoord;



@end
