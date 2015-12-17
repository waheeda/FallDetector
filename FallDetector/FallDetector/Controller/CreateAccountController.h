//
//  RegistrationController.h
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "BaseController.h"
#import "GoogleManager.h"

@interface CreateAccountController : BaseController <GoogleManagerDelegate>{
    NSMutableArray *_fetchedContacts;
}
-(void)performSignUpOperationWithEmail:(NSString*)email password:(NSString*)pass andSource:(NSString*)source;
-(void)signUpFromFacebook;
-(void)signUpFromGoogle;
@end
