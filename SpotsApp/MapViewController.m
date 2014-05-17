//
//  MapViewController.m
//  SpotsApp
//
//  Created by Andrey Poznyak on 07/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

@interface MapViewController () <GMSMapViewDelegate>

@end

@implementation MapViewController

@synthesize allHotSpots;
@synthesize currentSpot;

GMSMapView *mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: appdelegate.currentLatitude
                                                            longitude: appdelegate.currentLongitude
                                                                 zoom:12];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    mapView.delegate = self;
    
    [self createMarkers];
}

- (void)createMarkers
{
    for (HotSpot *spot in self.allHotSpots) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(spot.latitude, spot.longitude);
        marker.title = spot.name;
        marker.snippet = spot.bssid;
        marker.userData = @{
                            @"index": [NSNumber numberWithInt:[self.allHotSpots indexOfObject:spot]]
                            };
        marker.map = mapView;
    }
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    self.currentSpot = [self.allHotSpots objectAtIndex:[[marker.userData valueForKey:@"index"] intValue]];
    [self performSegueWithIdentifier:@"MapToDetailsSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MapToDetailsSegue"]) {
        [[segue destinationViewController] setCurrentSpot:self.currentSpot];
    }
}


@end
