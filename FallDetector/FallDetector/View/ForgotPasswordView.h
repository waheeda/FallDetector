//
//  ForgotPasswordView.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/17/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"

@interface ForgotPasswordView : BaseView <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *emailCentreConstraint;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@end
