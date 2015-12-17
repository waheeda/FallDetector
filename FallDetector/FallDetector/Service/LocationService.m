//
//  LocationService.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/15/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "LocationService.h"

@implementation LocationService
-(void)sendEmail:(NSString*)email withLocation:(CLLocationCoordinate2D)location withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    
    double longitude = location.longitude;
    double latitude = location.latitude;
    NSDictionary* parameters = @{@"email":email,
                                 @"longitude":[NSNumber numberWithDouble:longitude],
                                 @"latitude":[NSNumber numberWithDouble:latitude]};
    NSLog(@"%@",parameters);
    [http post:@"?rquest=sendEmail" parameters:parameters success:success failure:failure entity:nil];
}
@end
