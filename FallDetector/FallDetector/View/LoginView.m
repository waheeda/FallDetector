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


-(void)awakeFromNib{
     [GIDSignIn sharedInstance].uiDelegate = self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
   // [myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    //[self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onFBSignClick:(id)sender {
    [self.controller loginFromFacebook];
}
- (IBAction)onGoogleSignInClick:(id)sender {
    [[GIDSignIn sharedInstance] signIn];
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
    MatchListController *controller = [[MatchListController alloc] init];
    [[self.controller navigationController] pushViewController:controller animated:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.emailCentreConstraint.constant=-15;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}





@end