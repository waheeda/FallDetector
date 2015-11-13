//
//  LoginController.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "AuthService.h"
#import "User.h"
#import "UsersResponse.h"
#import "RegistrationController.h"

@interface LoginController ()

@property (nonatomic, weak) LoginController *weakSelf;
@end

@implementation LoginController

- (void)viewDidLoad{
    [super viewDidLoad];

    

}

- (void)openRegistrationController {

    RegistrationController *registrationController = [RegistrationController new];
    [super pushViewController:registrationController];

}




@end
