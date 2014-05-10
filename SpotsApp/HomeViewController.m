//
//  HomeViewController.m
//  SpotsApp
//
//  Created by Andrey Poznyak on 28/04/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize allHotSpots;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO: check the reponse to be correct
- (void)fetchSpots
{
    NSURL *getURL = [NSURL URLWithString: @"http://192.168.1.7:8765/hotspots"];
    
    
    //anynchronous request example goes here:
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: getURL
                                                               cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval: 60.0];
    
        [request setHTTPMethod: @"GET"];
        [request setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    
        [NSURLConnection sendAsynchronousRequest: request
                                           queue: queue
                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
                                   NSString *message = [[NSString alloc] init];
                                   if (error || !data) {
                                       message = [error localizedDescription];
                                   } else {
                                       NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                       if ([[result valueForKey:@"success"] boolValue]) {
                                           self.allHotSpots = [[NSArray alloc] initWithArray:[result valueForKey:@"spots"]];
                                           NSLog(@"Just received %lu hotspots", (unsigned long)[self.allHotSpots count]);
                                           //not to wait
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [self performSegueWithIdentifier:@"HomeToListSegue" sender:self];
                                           });
                                           
                                       } else {
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit result" message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                           //in order to remove delay and show alert immediately
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [alert show];
                                           });
                                       }
                                   }
                               }
         ];
    
}
- (IBAction)historyButtonPressed {
    [self fetchSpots];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"right before the segue");
    
    if ([segue.identifier isEqualToString:@"HomeToListSegue"]) {
        [[segue destinationViewController] setAllHotSpots:self.allHotSpots];
    }
}


@end
