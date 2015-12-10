//
//  User.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "User.h"
#import "ParserUtils.h"

@implementation User

-(void)set:(NSDictionary*)input{
    self.email= [ParserUtils stringValue:input key:@"email"];
    self.password   = [ParserUtils stringValue:input key:@"pwd"];
    self.source   = [ParserUtils stringValue:input key:@"source"];
    NSLog(@"Response was : %@", input);
}

@end
