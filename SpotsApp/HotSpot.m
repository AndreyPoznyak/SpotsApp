//
//  HotSpot.m
//  SpotsApp
//
//  Created by Andrey Poznyak on 04/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import "HotSpot.h"
#import "AppDelegate.h"

@implementation HotSpot

@synthesize longitude;
@synthesize latitude;
@synthesize name;
@synthesize bssid;

- (id)initWithName:(NSString *)newName andBssid:(NSString *)newBssid
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [self initWithName:newName andBssid:newBssid andLongitude:appdelegate.currentLongitude andLatitude:appdelegate.currentLatitude];
}

- (id)initWithName:(NSString *)newName andBssid:(NSString *)newBssid andLongitude:(double)newLongitude andLatitude:(double)newLatitude
{
    self = [super init];
    if (self) {
        self.name = newName;
        self.bssid = newBssid;
        self.latitude = newLatitude;
        self.longitude = newLongitude;
    }
    return self;
}

- (id)initWithObject: (id)data
{
    //TODO: add validation of existence
    self = [super init];
    if (self) {
        self.name = [data valueForKey:@"name"];
        self.bssid = [data valueForKey:@"bssid"];
        self.latitude = [[data valueForKey:@"latitude"] doubleValue];
        self.longitude = [[data valueForKey:@"longitude"] doubleValue];
    }
    return self;
}

- (NSData *)jsonData
{
    NSDictionary *jsonDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              self.name, @"name",
                              self.bssid, @"bssid",
                              [NSNumber numberWithDouble:self.latitude], @"latitude",
                              [NSNumber numberWithDouble:self.longitude], @"longitude",
                              @"Andrew", @"username",                     //TODO: replace this hardcoded username or move it
                              nil];
    
    NSData *json =[NSJSONSerialization dataWithJSONObject:jsonDict options:NSJSONWritingPrettyPrinted error:nil];
    
    return json;
}

@end
