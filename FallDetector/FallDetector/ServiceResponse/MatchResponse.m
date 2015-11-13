//
//  MatchResponse.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MatchResponse.h"
#import "Match.h"
#import "ParserUtils.h"
@implementation MatchResponse
-(void)set:(NSArray*)input{
    
    NSLog(@"%@", input);
    
    NSArray *matches = input;
    
    for (NSDictionary *match in matches) {
        Match *newMatch = [Match new];
        [newMatch set:match];
        [list addObject:newMatch];
    }
}
@end
