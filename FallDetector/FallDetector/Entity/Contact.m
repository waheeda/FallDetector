//
//  Contact.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/7/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "Contact.h"
#import "ParserUtils.h"

@implementation Contact
-(void)set:(NSDictionary*)input{
    NSLog(@"Response was : %@", input);
    self.name   = [ParserUtils stringValue:input key:@"contact_name"];
    self.number = [ParserUtils stringValue:input key:@"number"];
    self.email  = [ParserUtils stringValue:input key:@"email"];
}

-(NSDictionary*)getDictionary{
    NSDictionary *contact =  @{@"contact_name":self.name,
      @"number":self.number,
      @"email":self.email};
    return contact;
}

@end
