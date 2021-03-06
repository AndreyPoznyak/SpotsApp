//
//  HotSpotViewController.h
//  SpotsApp
//
//  Created by Andrey Poznyak on 02/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotSpot.h"

@interface HotSpotViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelBssid;
@property (weak, nonatomic) IBOutlet UILabel *labelLongitude;
@property (weak, nonatomic) IBOutlet UILabel *labelLatitude;

@property (strong, nonatomic) HotSpot *currentSpot;

- (IBAction)submitPressed;

@end
