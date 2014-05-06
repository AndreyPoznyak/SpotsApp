//
//  AppDelegate.h
//  SpotsApp
//
//  Created by Andrey Poznyak on 28/04/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) double currentLatitude;
@property (nonatomic) double currentLongitude;

@end
