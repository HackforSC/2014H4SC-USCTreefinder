//
//  DetailViewController.h
//  USCTreeFinder
//
//  Created by Dayton Pruet on 5/31/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define METERS_PER_MILE 1609.344

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,MKMapViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSDictionary *tree;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UILabel *treeId;
@property (strong, nonatomic) IBOutlet UILabel *treeCode;
@property (strong, nonatomic) IBOutlet UILabel *genus;
@property (strong, nonatomic) IBOutlet UILabel *species;
@property (strong, nonatomic) IBOutlet UILabel *common;
@property (strong, nonatomic) IBOutlet UILabel *heightClass;
@property (strong, nonatomic) IBOutlet UILabel *canopyRadiusClass;
@property (strong, nonatomic) IBOutlet UILabel *condition;
@property (strong, nonatomic) IBOutlet UILabel *estimatedValue;
@property (strong, nonatomic) IBOutlet UILabel *xCoordinate;
@property (strong, nonatomic) IBOutlet UILabel *yCoordinate;

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

@property (nonatomic) float XCoord;
@property (nonatomic) float YCoord;

- (void)configureView;


@end
