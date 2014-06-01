//
//  MapViewController.m
//  USCTreeFinder
//
//  Created by Dayton Pruet on 6/1/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import "MapViewController.h"
#import "CLPAddressAnnotation.h"
#import "StatePlanToLatLong.h"


@interface MapViewController ()

@end

@implementation MapViewController


- (void)configureView {
    // 33.9946202,-81.0284514  - USC Campus Lat & Long
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 33.9946202;
    zoomLocation.longitude = -81.0284514;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1.0*METERS_PER_MILE, 1.0*METERS_PER_MILE);
    [_myMapView setRegion:viewRegion animated:YES];

    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta=0.010;
    span.longitudeDelta=0.010;
    
    region.span=span;
    region.center=zoomLocation;
        
    [_myMapView setMapType:MKMapTypeHybrid];
    [_myMapView setRegion:region animated:TRUE];
    [_myMapView regionThatFits:region];
    
}

- (void)loadAllTrees {
    
    int i = 0;
    
    _annPinArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *tree in _trees) {
        
        i += 1;
        
        if ([tree[@"XCoord"] isKindOfClass:[NSNull class]]) {
            _XCoord = 0.0;
        } else {
            _XCoord = floor([tree[@"XCoord"] floatValue]);  //Long
        }
        
        if ([tree[@"YCoord"] isKindOfClass:[NSNull class]]) {
            _YCoord = 0.0;
        } else {
            
            _YCoord = floor([tree[@"YCoord"] floatValue]);  //Long
        }
        
        if ((_XCoord != 0.0) && (_XCoord != 0.0)) {
            StatePlanToLatLong *converter = [[StatePlanToLatLong alloc] init];
            
            //CLLocationCoordinate2D treeCoord = [converter convert:_YCoord YCoordinate:_XCoord];
            CLLocationCoordinate2D treeCoord = [converter convert:_XCoord YCoordinate:_YCoord];
            
            CLPAddressAnnotation *annotationAddress = [[CLPAddressAnnotation alloc] initWithCoordinate:treeCoord];
            [_annPinArray addObject:annotationAddress];
        }
        
        /*
        if (i == 50) {
            break;
        }
         */
        
    }
    
    [_myMapView addAnnotations:_annPinArray];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSError *error;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"convertcsv"
                                                         ofType:@"json"];
    NSString* contents = [NSString stringWithContentsOfFile:filePath
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    NSData* jsonData = [contents dataUsingEncoding:NSUTF8StringEncoding];
    
    _trees = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    
    //self.title = _tree[@"Common"];
    [self configureView];
    [self loadAllTrees];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
