//
//  LoginView.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "LoginView.h"
#import "LoginController.h"
#import "EmergencyTimerController.h"
#import "EmergencyContactsInitialController.h"
#import "StringUtils.h"
#import "Alert.h"
@interface LoginView()

@property (nonatomic, weak) LoginController *controller;

@end

@implementation LoginView
@dynamic controller;


-(void)awakeFromNib{
    
}
- (IBAction)onForgotPasswordClick:(id)sender {
    [self.controller showForgotPasswordController];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onFBSignClick:(id)sender {
    [self.controller loginFromFacebook];
}
- (IBAction)onGoogleSignInClick:(id)sender {
    [self.controller loginFromGoogle];
}

-(void)setData:(NSArray*)data{

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

- (IBAction)onSignInClick:(id)sender {
    if(![StringUtils validateEmail:self.emailField.text]){
        [Alert show:@"Error" andMessage:@"Invalid Email Address"];
        self.emailField.text=@"";
    }
    
    else if([StringUtils validateForNull:self.passField.text])
        [Alert show:@"Error" andMessage:@"Please Enter your Password"];
    
    else
        [self.controller authenticateUser:self.emailField.text andPassword:self.passField.text];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.emailCentreConstraint.constant=-15;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

@end