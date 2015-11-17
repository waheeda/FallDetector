//
//  LoginView.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "LoginView.h"
#import "LoginController.h"
#import "MatchListController.h"

@interface LoginView()

@property (nonatomic, weak) LoginController *controller;

@end

@implementation LoginView
@dynamic controller;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(NSArray*)data{

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    self.emailCentreConstraint.constant=-110;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (IBAction)onSignInClick:(id)sender {
    MatchListController *controller = [[MatchListController alloc] init];
    [[self.controller navigationController] pushViewController:controller animated:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.emailCentreConstraint.constant=-20;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}


- (IBAction)openRegistrationController:(id)sender {

    [self.controller openRegistrationController];
    
}


@end