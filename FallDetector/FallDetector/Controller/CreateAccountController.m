//
//  RegistrationController.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "CreateAccountController.h"
#import "CreateAccountView.h"
#import "Service.h"

@interface CreateAccountController ()
@property (nonatomic, weak) CreateAccountController *weakSelf;
@end

@implementation CreateAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    _weakSelf = self;
    self.navigationController.navigationBarHidden=false;
    [self setupNavBar];
    self.title=@"Create Account";
    [super loadServices:@[@(ServiceTypeAuth) , @(ServiceTypeUser)]];
   // [self getUser];
}



- (void) getUser {

    [service.user getUser:^(id response) {

    } andfailure:^(NSError *error) {
        [_weakSelf onServiceResponseFailure:error];
    }];
}

-(void) getPhotos {

    [service.auth getPhotos:^(id response) {
        [_weakSelf publishMessage];
    } andfailure:^(NSError *error) {
        [_weakSelf onServiceResponseFailure:error];
    }];

}
-(void) publishMessage {

    [service.auth publishMessage:^(id response) {
    } andfailure:^(NSError *error) {
        [_weakSelf onServiceResponseFailure:error];
    }];
    
}

@end
