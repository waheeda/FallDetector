//
//  LoginController.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginController.h"
#import "LoginView.h"
#import "AuthService.h"
#import "User.h"
#import "UsersResponse.h"
#import "CreateAccountController.h"
#import "UserDefaults.h"
#import "MonitoringController.h"
#import "InfoController.h"
#import "MenuController.h"
#import "AppDelegate.h"

@interface LoginController ()

@property (nonatomic, weak) LoginController *weakSelf;
@end

@implementation LoginController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=false;
    [self setupNavBar];
    self.title=@"Sign In";
    [[GoogleManager instance] setDelegate:self];
}

//changes
-(void)loginFromFacebook{
    [self showLoaderOnUIView:self.view];
    [FacebookManager loginWithViewController:self andCallback:^(id result, NSError *error) {
        [self hideLoader];
        if(!error){
            //[self openMonitoringController];
            [self showMonitoringController];
        }
        else{
            [self onServiceResponseFailure:error];
        }
    }];
}

-(void)loginFromGoogle{
    [self showLoaderOnUIView:self.view];
    [GoogleManager signIn];
}

//Delegate Methods
-(void)onGoogleSignIn{
    [self hideLoader];
    [self showMonitoringController];
}

-(void)showMonitoringController{
    [[AppDelegate getInstance] showMonitoringController];
}

-(void)presentGoogleViewController:(UIViewController*) controller{
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)dismissGoogleViewController:(UIViewController*) controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
