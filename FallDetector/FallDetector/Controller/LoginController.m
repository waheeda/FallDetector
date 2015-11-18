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
    self.navigationController.navigationBarHidden=false;
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:249/255.0f green:146/255.0f blue:10/255.0f alpha:1.0f]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
   // self.title=@"Sign In";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:249/255.0f green:146/255.0f blue:10/255.0f alpha:1.0f],
                                                                      NSFontAttributeName:[UIFont
                                                                                           fontWithName:@"Helvetica" size:18]}];
    

}

- (void)openRegistrationController {

    RegistrationController *registrationController = [RegistrationController new];
    [super pushViewController:registrationController];

}




@end
