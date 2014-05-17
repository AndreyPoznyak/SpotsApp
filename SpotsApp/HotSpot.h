//
//  HotSpot.h
//  SpotsApp
//
//  Created by Andrey Poznyak on 04/05/14.
//  Copyright (c) 2014 andreypoznyak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotSpot : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bssid;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

- (id)initWithName: (NSString *)newName andBssid: (NSString *)newBssid;
- (id)initWithName:(NSString *)newName andBssid:(NSString *)newBssid andLongitude:(double)newLongitude andLatitude:(double)newLatitude;
- (id)initWithObject: (id)data;
- (NSData *)jsonData;

@end
