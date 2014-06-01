//
//  DetailViewController.m
//  USCTreeFinder
//
//  Created by Dayton Pruet on 5/31/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import "DetailViewController.h"
#import "Tree.h"
//#import "GeodeticUTMConverter.h"
#import "CLPAddressAnnotation.h"
#import "StatePlanToLatLong.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}


- (void)configureView {
    self.title = _tree[@"Common"];
    _treeId.text = [NSString stringWithFormat:@"%@ - %@",_tree[@"TreeID"],_tree[@"TreeCode"]];
    _genus.text = [NSString stringWithFormat:@"%@ - %@",_tree[@"Genus"],_tree[@"Species"]];
    _common.text = _tree[@"Common"];
    _heightClass.text = _tree[@"HeightClass"];
    _canopyRadiusClass.text = _tree[@"CanopyRadiusClass"];
    _condition.text = _tree[@"Condition"];
    _estimatedValue.text = _tree[@"EstimatedValue"];
    
    _XCoord = floor([_tree[@"XCoord"] floatValue]);  //Long
    _YCoord = floor([_tree[@"YCoord"] floatValue]);  //Long
    
    //_xCoordinate.text = [NSString stringWithFormat:@"%.f", _XCoord];
    //_yCoordinate.text = [NSString stringWithFormat:@"%.f", _YCoord];
    
    
    
    if ((_XCoord == 0.0) || (_XCoord == 0.0)) {
        // 33.9946202,-81.0284514  - USC Campus Lat & Long
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = 33.9946202;
        zoomLocation.longitude = -81.0284514;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1.0*METERS_PER_MILE, 1.0*METERS_PER_MILE);
        [_myMapView setRegion:viewRegion animated:YES];
    } else {
        /*
        // Convert UTM to Degrees
        UTMCoordinates coordinates;
        coordinates.gridZone = 17;
        coordinates.northing = _YCoord;
        coordinates.easting = _XCoord;
        coordinates.hemisphere = kUTMHemisphereNorthern;
        
        GeodeticUTMConverter *converter = [[GeodeticUTMConverter alloc] init];
        CLLocationCoordinate2D treeCoord = [converter UTMCoordinatesToLatitudeAndLongitude:coordinates];
        */
        
        
        StatePlanToLatLong *converter = [[StatePlanToLatLong alloc] init];
        
        //CLLocationCoordinate2D treeCoord = [converter convert:_YCoord YCoordinate:_XCoord];
        CLLocationCoordinate2D treeCoord = [converter convert:_XCoord YCoordinate:_YCoord];
        
        CLPAddressAnnotation *annotationAddress = [[CLPAddressAnnotation alloc] initWithCoordinate:treeCoord];
        
    
        _xCoordinate.text = [NSString stringWithFormat:@"%.8f", treeCoord.latitude];
        _yCoordinate.text = [NSString stringWithFormat:@"%.8f", treeCoord.longitude];
        
        [_myMapView addAnnotation:annotationAddress];
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        
        span.latitudeDelta=0.0005;
        span.longitudeDelta=0.0005;
        
        region.span=span;
        region.center=treeCoord;
        
        [_myMapView setMapType:MKMapTypeHybrid];
        [_myMapView setRegion:region animated:TRUE];
        [_myMapView regionThatFits:region];

    }
    
    //_xCoordinate.text = [NSString stringWithFormat:@"%.f", treeCoorf];
    //_yCoordinate.text = [NSString stringWithFormat:@"%.f", _YCoord];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = _tree[@"Common"];
    [self configureView];
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = _tree[@"Common"];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
