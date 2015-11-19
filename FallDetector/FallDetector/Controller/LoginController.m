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
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
   // self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.title=@"Sign In";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:101/255.0f green:101/255.0f blue:101/255.0f alpha:1.0f]];
    //[[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x067AB5)]; //249,146,10

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    //self.navigationItem.leftBarButtonItem = [super createBackButton:self selector:@selector(popViewController)];
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    
    //self.controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"fes" style:UIBarButtonItemStylePlain target:nil action:nil];
    //[self.navigationController.navigationItem.backBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

- (void)openRegistrationController {

    RegistrationController *registrationController = [RegistrationController new];
    [super pushViewController:registrationController];

}




@end
