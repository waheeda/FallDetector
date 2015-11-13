//
//  MatchService.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseService.h"

@interface MatchService : BaseService
-(void)getMatches:(successCallback)success andfailure:(failureCallback)failure;

//-(void)getUser:(successCallback)success andfailure:(failureCallback)failure;
@end
