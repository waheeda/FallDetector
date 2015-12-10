//
//  ContactService.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/7/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseService.h"
#import "Contact.h"
@interface ContactService : BaseService
-(void) getContactsofEmail:(NSDictionary*)email withSuccess:(successCallback)success andfailure:(failureCallback)failure;
-(void)addContactofEmail:(NSString*)email andContact:(Contact*)contact withSuccess:(successCallback)success andfailure:(failureCallback)failure;
@end
