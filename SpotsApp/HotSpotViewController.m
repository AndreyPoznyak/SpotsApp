//
//  HotSpotViewController.m
//  SpotsApp
//
//  Created by Andrey Poznyak on 02/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import "HotSpotViewController.h"

@interface HotSpotViewController ()

@end

@implementation HotSpotViewController

@synthesize labelBssid;
@synthesize labelLatitude;
@synthesize labelLongitude;
@synthesize labelName;
@synthesize currentSpot;

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
    [super viewDidLoad];
            
    [self.labelName setText: self.currentSpot.name];
    [self.labelBssid setText: self.currentSpot.bssid];
    [self.labelLongitude setText: [NSString stringWithFormat:@"%.0f", self.currentSpot.longitude]];
    [self.labelLatitude setText: [NSString stringWithFormat:@"%.0f", self.currentSpot.latitude]];

}

- (void)sendSpotToService
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURL *postURL = [NSURL URLWithString: @"http://192.168.1.4:8765/hotspot"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: postURL
                                                           cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval: 60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [request setHTTPBody: [self.currentSpot jsonData]];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: queue
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSString *message = [[NSString alloc] init];
                               if (error || !data) {
                                   message = [error localizedDescription];
                               } else {
                                   message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               }
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit result" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                               //in order to remove delay and show alert immediately
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [alert show];
                               });
                           }
     ];
}

- (IBAction)submitPressed
{
    //send this shit to the service somehow here
    [self sendSpotToService];
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
