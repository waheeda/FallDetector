//
//  RegistrationController.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "RegistrationController.h"
#import "RegistrationView.h"
#import "Service.h"

@interface RegistrationController ()
@property (nonatomic, weak) RegistrationController *weakSelf;
@end

@implementation RegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    _weakSelf = self;
    [super loadServices:@[@(ServiceTypeAuth) , @(ServiceTypeUser)]];
    [self getUser];
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
