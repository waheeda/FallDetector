//
//  RegistrationView.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "CreateAccountView.h"
#import "CreateAccountController.h"
#import "Alert.h"
@implementation CreateAccountView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)onFacebookSignupButtonClick:(id)sender {
    [(CreateAccountController*)self.controller signUpFromFacebook];
}

- (IBAction)onSignUpButtonClick:(id)sender {
    if(![self textFieldIsEmpty:self.emailField] && ![self textFieldIsEmpty:self.passField]){
        [(CreateAccountController*)self.controller performSignUpOperationWithEmail:self.emailField.text password:self.passField.text andSource:@"Default"];
        return;
    }
    [self validateFields];
}

- (IBAction)onGoogleSignUpButtonClick:(id)sender {
    [(CreateAccountController*)self.controller signUpFromGoogle];
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

-(void)validateFields{
    if([self textFieldIsEmpty:self.emailField]){
        [Alert show:@"Error" andMessage:@"Please Enter Email"];
    }
    else if([self textFieldIsEmpty:self.passField]){
        [Alert show:@"Error" andMessage:@"Password cannot be blank"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.emailCentreConstraint.constant=-15;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

-(BOOL)textFieldIsEmpty:(UITextField*)textField{
    if([textField.text length]==0)
        return true;
    return false;
}

-(void)clearFields{
    self.emailField.text=@"";
    self.passField.text=@"";
}

@end
