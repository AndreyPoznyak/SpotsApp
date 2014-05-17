//
//  NetworksListTableViewController.h
//  SpotsApp
//
//  Created by Andrey Poznyak on 28/04/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotSpot.h"

@interface NetworksListTableViewController : UITableViewController

@property (nonatomic, retain) NSArray *allHotSpots;
@property (strong, nonatomic) HotSpot *currentSpot;

@end
