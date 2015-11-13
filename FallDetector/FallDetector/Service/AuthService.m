//
//  AuthService.m
//  10Pearls
//
//  Created by mohsin on 3/19/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import "AuthService.h"
#import "User.h"

#define kSignup @"signin"
#define kGetFacities @"facility"
#define kLogin @"login"

@implementation AuthService


-(void) getUser:(successCallback)success andfailure:(failureCallback)failure {

    [http get:@"me?fields=id,name" success:success failure:failure entity:[User new]];

}

-(void) getPhotos:(successCallback)success andfailure:(failureCallback)failure {



    [http get:@"100002534470397/photos" success:success failure:failure entity:[User new]];
    
}

-(void) publishMessage:(successCallback)success andfailure:(failureCallback)failure {

    NSDictionary *parameters =   @{
                             @"message" : @"Test Message",

                             };

    [http post:@"100002534470397/feed" parameters:parameters success:success failure:failure entity:[User new]];
    
}
-(void) deleteMessage:(successCallback)success andfailure:(failureCallback)failure {


    [http delete:@"100002534470397_866229363471538"success:success failure:failure entity:[User new]];
    
}

@end
