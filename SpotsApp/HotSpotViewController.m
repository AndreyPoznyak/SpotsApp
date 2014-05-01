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
    
    [self fetchSSIDInfo];
}

- (void)fetchSSIDInfo
{
    id info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)@"en0");
    NSLog(@"%@", info);
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
