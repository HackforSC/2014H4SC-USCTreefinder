//
//  MasterViewController.h
//  USCTreeFinder
//
//  Created by Dayton Pruet on 5/31/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *trees;
@property (strong,nonatomic) NSDictionary *tree;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
