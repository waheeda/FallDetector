//
//  RegistrationView.h
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "BaseView.h"
#import "User.h"

@interface CreateAccountView : BaseView <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *emailCentreConstraint;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passField;
-(void)clearFields;
@end
