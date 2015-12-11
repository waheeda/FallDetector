//
//  ContactService.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/7/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ContactService.h"
#import "ContactsResponse.h"

@implementation ContactService

-(void) getContactsofEmail:(NSDictionary*)email withSuccess:(successCallback)success andfailure:(failureCallback)failure {
    [http post:@"?rquest=getContacts" parameters:email success:success failure:failure response:[ContactsResponse new]];
}

-(void)addContactofEmail:(NSString*)email andContact:(Contact*)contact withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    NSDictionary* parameters = @{@"username_email":email,
                                 @"contact_name":contact.name,
                                 @"number":contact.number,
                                 @"email":contact.email};
    [http put:@"?rquest=addContact" parameters:parameters success:success failure:failure entity:nil];
}

-(void)deleteContactOfEmail:(NSString*)email withSuccess:(successCallback)success andfailure:(failureCallback)failure{
    
    [http delete:[NSString stringWithFormat:@"?rquest=deleteContact&username_email=%@",email] success:success failure:failure entity:nil];
}

@end
