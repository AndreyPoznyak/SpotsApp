//
//  HotSpotViewController.m
//  SpotsApp
//
//  Created by Andrey Poznyak on 02/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import "HotSpotViewController.h"
#import "AppDelegate.h"


@interface HotSpotViewController ()

@end

@implementation HotSpotViewController

@synthesize labelBssid;
@synthesize labelLatitude;
@synthesize labelLongitude;
@synthesize labelName;

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
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    id info = [self fetchSSIDInfo];
    
    [self.labelName setText: info[@"SSID"]];
    [self.labelBssid setText: info[@"BSSID"]];
    [self.labelLongitude setText: [NSString stringWithFormat:@"%.0f", appdelegate.currentLongitude]];
    [self.labelLatitude setText: [NSString stringWithFormat:@"%.0f", appdelegate.currentLatitude]];

}

- (id)fetchSSIDInfo
{
    return (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)@"en0");
}

- (void)testSendingToService
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURL *postURL = [NSURL URLWithString: @"http://texas/WebSite3/Service.asmx/doSomething"];
    NSDictionary *jsonDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              @"test@gmail.com", @"email",
                              @"John Doe", @"name",
                              nil];
    
    NSString *postValues = [jsonDict urlEncodedString];
    NSData *jsonData = [postValues dataUsingEncoding: NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: postURL
                                                           cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval: 60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    // [request setValue: @"application/json" forHTTPHeaderField: @"content-type"];
    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"content-type"];
    [request setHTTPBody: jsonData];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: queue
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error || !data) {
                                   // Handle the error
                               } else {
                                   // Handle the success
                               }
                           }
     ];
}

- (IBAction)submitPressed
{
    //send this shit to the service somehow here
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
