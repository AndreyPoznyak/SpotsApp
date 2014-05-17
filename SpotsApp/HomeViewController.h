//
//  HomeViewController.h
//  SpotsApp
//
//  Created by Andrey Poznyak on 28/04/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "HotSpot.h"


@interface HomeViewController : UIViewController

@property (nonatomic, retain) NSArray *allHotSpots;
@property (strong, nonatomic) HotSpot *currentSpot;

@end
