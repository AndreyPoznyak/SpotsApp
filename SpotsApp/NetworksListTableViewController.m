//
//  NetworksListTableViewController.m
//  SpotsApp
//
//  Created by Andrey Poznyak on 28/04/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import "NetworksListTableViewController.h"

@interface NetworksListTableViewController ()

@end

@implementation NetworksListTableViewController

@synthesize allHotSpots;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

//TODO: check the reponse to be correct
//- (void)fetchSpots
//{
//    NSURL *getURL = [NSURL URLWithString: @"http://192.168.1.7:8765/hotspots"];
//    
//    
//    //synchronous request
////    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:getURL];
////    NSURLResponse * response = nil;
////    NSError * error = nil;
////    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
////                                          returningResponse:&response
////                                                      error:&error];
////    
////    if (error == nil) {
////        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
////        if ([[result valueForKey:@"success"] boolValue]) {
////            self.allHotSpots = [[NSArray alloc] initWithObjects:[result valueForKey:@"spots"], nil];
////        } else {
////            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit result" message:[result valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
////            //in order to remove delay and show alert immediately
////            dispatch_async(dispatch_get_main_queue(), ^{
////                [alert show];
////            });
////        }
////    } else {
////        NSLog(@"%@", [error localizedDescription]);
////    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.allHotSpots count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ListToMapSegue" sender:self];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"wtf";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.row == 0) {
        [cell.textLabel setText:@"View all on map"];
    } else {
        [cell.textLabel setText:[[self.allHotSpots objectAtIndex:indexPath.row - 1] valueForKey: @"name" ]];
        [cell.detailTextLabel setText:[[self.allHotSpots objectAtIndex:indexPath.row - 1] valueForKey: @"bssid" ]];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     [[segue destinationViewController] setAllHotSpots:self.allHotSpots];
}


@end
