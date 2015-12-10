//
//  ContactsResponse.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/7/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ContactsResponse.h"
#import "Contact.h"
@implementation ContactsResponse
-(void)set:(NSArray*)input{
    NSLog(@"%@", input);
    NSArray *contacts = input;
    for (NSDictionary *contact in contacts) {
        Contact *newContact = [Contact new];
        [newContact set:contact];
        [list addObject:newContact];
    }
}
@end
