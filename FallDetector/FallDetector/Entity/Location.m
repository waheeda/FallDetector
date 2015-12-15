//
//  Location.h
//  GUARDIAN
//
//  Created by Hamiz Ahmed on 10/16/14.
//  Copyright (c) 2015 DeadRinger. All rights reserved.
//

#import "Location.h"
#import <CoreLocation/CoreLocation.h>
#import "ParserUtils.h"


@implementation Location
-(void)set:(NSDictionary*)data{
    
    NSArray *coordinates = [ParserUtils object:data key:@"coordinates"];
    double latitude = [[coordinates firstObject] doubleValue];
    double longitude = [[coordinates lastObject] doubleValue];
    self.coordinates = CLLocationCoordinate2DMake(latitude, longitude);
    self.name = [ParserUtils stringValue:data key:@"name"];
    self.city =[ParserUtils stringValue:data key:@"city"];
    self.state =[ParserUtils stringValue:data key:@"state"];
    self.zipCode =[ParserUtils stringValue:data key:@"zipCode"];
    self.country =[ParserUtils stringValue:data key:@"country"];
    self.address =[ParserUtils stringValue:data key:@"address"];
}

-(void) setWithCoreLocation:(CLLocation *) object {
    
    self.coordinates = object.coordinate;
    self.name = object.description;
}



@end
