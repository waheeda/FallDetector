//
//  UserService.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "User.h"

@interface UserService : BaseService

-(void)getUsers:(successCallback)success andfailure:(failureCallback)failure;

-(void)getUser:(successCallback)success andfailure:(failureCallback)failure;
-(void)userExistInDBofEmail:(NSString*)email withSuccess:(successCallback)success andfailure:(failureCallback)failure;
-(void)insertUser:(User*)user withSuccess:(successCallback)success andfailure:(failureCallback)failure;
@end
