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
    [self fetchSpots];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

//TODO: check the reponse to be correct
- (void)fetchSpots
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURL *getURL = [NSURL URLWithString: @"http://192.168.1.6:8765/hotspots"];
    
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
                                   NSLog(message);
                               } else {
                                   NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   if ([result valueForKey:@"success"]) {
                                       self.allHotSpots = [[NSArray alloc] initWithObjects:[result valueForKey:@"spots"], nil];
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
    return [self.allHotSpots count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"wtf";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:[[self.allHotSpots objectAtIndex:indexPath.row] valueForKey: @"name" ]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
