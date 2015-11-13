//
//  MatchService.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MatchService.h"
#import "MatchResponse.h"
#define kMethodGetMatches @"/csa"
#define kMethodGetUser  @"users/me"
@implementation MatchService
-(void)getMatches:(successCallback)success andfailure:(failureCallback)failure{
    [http get:kMethodGetMatches success:success failure:false response:nil];
}
@end
