//
//  ForgotPasswordView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/17/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "ForgotPasswordView.h"
#import "ForgotPasswordController.h"
#import "StringUtils.h"
#import "Alert.h"
@implementation ForgotPasswordView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)onSubmitButtonClick:(id)sender {
    if([StringUtils validateEmail:self.emailTextField.text])
        [(ForgotPasswordController*)self.controller forgotPassword:[self.emailTextField text]];
    else
        [Alert show:@"Error" andMessage:@"Invalid Email Address. Kindly enter a valid email address"];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    self.emailCentreConstraint.constant=-180;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.emailCentreConstraint.constant=40;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
