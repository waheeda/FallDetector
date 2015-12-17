//
//  LocationService.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/15/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseService.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationService : BaseService
-(void)sendEmail:(NSString*)email withLocation:(CLLocationCoordinate2D)location withSuccess:(successCallback)success andfailure:(failureCallback)failure;
@end
