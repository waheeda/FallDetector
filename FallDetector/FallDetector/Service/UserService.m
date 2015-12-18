//
//  UserService.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "UserService.h"

#import "UsersResponse.h"

#define kMethodGetUsers @"v1/users"
#define kMethodGetUser  @"users/me"
#define kMethodCheckUser  @"?rquest=isAUser"
#define kMethodAddUser  @"?rquest=addUser"
#define kMethodForgotPwd  @"?rquest=forgotPassword"

@implementation UserService

-(void)getUsers:(successCallback)success andfailure:(failureCallback)failure{
    [http get:kMethodGetUsers success:success failure:false response:[UsersResponse new]];
}

-(void)getUser:(successCallback)success andfailure:(failureCallback)failure{
    [http get:kMethodGetUser success:success failure:false response:[UsersResponse new]];
}

-(void)userExistInDBofEmail:(NSString*)email withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    NSDictionary *parameters = @{@"email":email};
    [http post:kMethodCheckUser parameters:parameters success:success failure:failure entity:nil];
}

-(void)insertUser:(User*)user withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    NSDictionary *parameters = @{@"email":user.email,
                                 @"pwd":user.password,
                                 @"source":user.source};
    [http put:kMethodAddUser parameters:parameters success:success failure:failure entity:nil];
}

-(void)forgotPasswordOfEmail:(NSString*)email withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    NSDictionary *parameters = @{@"email":email,
                                 };
    [http post:kMethodForgotPwd parameters:parameters success:success failure:failure entity:nil];
}

@end
