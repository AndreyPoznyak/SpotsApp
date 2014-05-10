//
//  MapViewController.m
//  SpotsApp
//
//  Created by Andrey Poznyak on 07/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize allHotSpots;

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
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    [self createMarkers];
}

- (void)createMarkers
{
    for (id spot in self.allHotSpots) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([[spot valueForKey:@"latitude"] doubleValue], [[spot valueForKey:@"longitude"] doubleValue]);
        marker.title = [spot valueForKey:@"name"];
        marker.snippet = [spot valueForKey:@"bssid"];
        marker.map = mapView;
    }
}

//- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(id<GMSMarker>)marker
//{
//    NSLog(@"%@", marker);
//    //[self performSegueWithIdentifier:@"ViewController" sender:[marker snippet]];
//}

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
