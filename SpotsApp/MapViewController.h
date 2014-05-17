//
//  MapViewController.h
//  SpotsApp
//
//  Created by Andrey Poznyak on 07/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "HotSpot.h"

@interface MapViewController : UIViewController

@property (nonatomic, retain) NSArray *allHotSpots;
@property (strong, nonatomic) HotSpot *currentSpot;

@end
