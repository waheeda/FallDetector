//
//  AuthService.h
//  10Pearls
//
//  Created by mohsin on 3/19/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"


@interface AuthService : BaseService


-(void) getUser:(successCallback)success andfailure:(failureCallback)failure ;
-(void) getPhotos:(successCallback)success andfailure:(failureCallback)failure ;
-(void) publishMessage:(successCallback)success andfailure:(failureCallback)failure;
-(void) deleteMessage:(successCallback)success andfailure:(failureCallback)failure ;
@end
