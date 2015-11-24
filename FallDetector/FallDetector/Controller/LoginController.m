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

@interface LoginController ()

@property (nonatomic, weak) LoginController *weakSelf;
@end

@implementation LoginController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=false;
    [self setupNavBar];
    self.title=@"Sign In";
}


-(void)loginFromFacebook{
    [self showLoaderOnUIView:self.view];
    [FacebookManager loginWithViewController:self andCallback:^(id result, NSError *error) {
        [self hideLoader];
        if(!error){
            [self openMonitoringController];
        }
        else{
            [self onServiceResponseFailure:error];
        }
    }];
}

-(void)openMonitoringController{
    MonitoringController *controller = [[MonitoringController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
