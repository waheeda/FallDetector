//
//  Match.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "Match.h"
#import "ParserUtils.h"
@implementation Match
-(void)set:(NSDictionary*)input{
        self.team1   = [ParserUtils stringValue:input key:@"t1"];
        self.team2 = [ParserUtils stringValue:input key:@"t2"];
        self.matchID = [ParserUtils stringValue:input key:@"id"];
    
    NSLog(@"Response was : %@", input);
}
@end
