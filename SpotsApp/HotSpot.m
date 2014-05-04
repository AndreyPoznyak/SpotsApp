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

    self = [super init];
    if (self) {
        self.name = newName;
        self.bssid = newBssid;
        self.latitude = appdelegate.currentLatitude;
        self.longitude = appdelegate.currentLongitude;
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
