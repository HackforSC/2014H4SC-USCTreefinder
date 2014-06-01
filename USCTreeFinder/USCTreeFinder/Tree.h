//
//  Tree.h
//  USCTreeFinder
//
//  Created by Dayton Pruet on 5/31/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tree : NSObject

@property (nonatomic,strong) NSString *TreeID;
@property (nonatomic,strong) NSString *TreeCode;
@property (nonatomic,strong) NSString *Genus;
@property (nonatomic,strong) NSString *Species;
@property (nonatomic,strong) NSString *Common;
@property (nonatomic,strong) NSString *XCoord;
@property (nonatomic,strong) NSString *YCoord;
@property (nonatomic,strong) NSString *TagNum;
@property (nonatomic,strong) NSString *DateInventoried;
@property (nonatomic,strong) NSString *LastUpdated;
@property (nonatomic,strong) NSString *Diameter;
@property (nonatomic,strong) NSString *HeightClass;
@property (nonatomic,strong) NSString *HeightNum;
@property (nonatomic,strong) NSString *CanopyRadiusClass;
@property (nonatomic,strong) NSString *CanopyRadiusNum;
@property (nonatomic,strong) NSString *Stems;
@property (nonatomic,strong) NSString *LocationType;
@property (nonatomic,strong) NSString *SiteSizeClass;
@property (nonatomic,strong) NSString *LocationValue;
@property (nonatomic,strong) NSString *SiteSizeNum;
@property (nonatomic,strong) NSString *Condition;
@property (nonatomic,strong) NSString *Owner;
@property (nonatomic,strong) NSString *Area;
@property (nonatomic,strong) NSString *Notes;
@property (nonatomic,strong) NSString *Address;
@property (nonatomic,strong) NSString *StreetName;
@property (nonatomic,strong) NSString *OtherAddress;
@property (nonatomic,strong) NSString *Technician;
@property (nonatomic,strong) NSString *TreePlantingSpace;
@property (nonatomic,strong) NSString *TPSPriority;
@property (nonatomic,strong) NSString *EstimatedValue;
@property (nonatomic,strong) NSString *Custom1;
@property (nonatomic,strong) NSString *Custom2;
@property (nonatomic,strong) NSString *Priority;
@property (nonatomic,strong) NSString *Building;


@end
