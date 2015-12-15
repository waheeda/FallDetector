//
//  Location.h
//  GUARDIAN
//
//  Created by Hamiz Ahmed on 10/16/14.
//  Copyright (c) 2015 DeadRinger. All rights reserved.
//

#import "BaseEntity.h"
#import <CoreLocation/CoreLocation.h>

@interface Location : BaseEntity
@property(nonatomic,strong) NSString *name;
@property(nonatomic) CLLocationCoordinate2D coordinates;

@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) NSString *state;
@property(nonatomic, strong) NSString *zipCode;
@property(nonatomic, strong) NSString *country;
@property(nonatomic, strong) NSString *address;


-(void) set:(NSDictionary*)data;
-(void) setWithCoreLocation:(CLLocation *) object;

@end
