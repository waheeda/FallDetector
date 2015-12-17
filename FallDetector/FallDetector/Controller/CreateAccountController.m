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
#import "EmergencyContactsInitialController.h"
#import "User.h"
#import "UserDefaults.h"
#import "Alert.h"
#import "CreateAccountView.h"
#import "FacebookManager.h"
#import "ContactsResponse.h"
#import "AppDelegate.h"


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
    [[GoogleManager instance] setDelegate:self];
    [super loadServices:@[@(ServiceTypeAuth), @(ServiceTypeUser), @(ServiceTypeContacts)]];
   // [self getUser];
}


-(void)signUpFromFacebook{
    [self showLoaderOnUIView:self.view];
    [FacebookManager loginWithViewController:self andCallback:^(id result, NSError *error) {
        [self hideLoaderOnUIView:self.view];
        if([result valueForKey:@"isCancelled"]){
            [self hideLoaderOnUIView:self.view];
            [Alert show:@"Login Failed" andMessage:@"Sign Up operation cancelled"];
        }
        
        else if([result valueForKey:@"email"]){
            //[self performLoginOperationWithEmail: andSource:@"Facebook"];
            [self performSignUpOperationWithEmail:[result valueForKey:@"email"] password:@"" andSource:@"Facebook"];
        }
        else{
            [self onServiceResponseFailure:error];
        }
    }];
}

-(void)signUpFromGoogle{
    [self showLoader];
    [GoogleManager signIn];
}

//Delegate Methods
//Delegate Methods
-(void)onGoogleSignInWithEmail:(NSString *)email{
    [self hideLoader];
    [self performSignUpOperationWithEmail:email password:@"" andSource:@"Google"];
    //[self showEmergencyContactsInitialController];
}

-(void)onSignInError:(NSError*)error{
    [self hideLoader];
    [Alert show:@"Login Failed" andMessage:@"Login operation cancelled"];
}

-(void)presentGoogleViewController:(UIViewController*) controller{
    [self presentViewController:controller animated:YES completion:nil];
    [self hideLoader];
}

-(void)dismissGoogleViewController:(UIViewController*) controller{
    [self showLoader];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fetchContactsOfEmail:(NSString*)email{
    NSDictionary *params =@{@"email":email};
    [service.contact getContactsofEmail:params withSuccess:^(id response) {
        [self getDictionaryFromEntity:[(ContactsResponse*)response getList]];
        [UserDefaults setEmergencyContacts:_fetchedContacts];
        [UserDefaults saveEmailInUserDefaults:email];
        [self showMonitoringController];
    } andfailure:^(NSError *error) {
        [self onServiceResponseFailure:error];
    }];
}

-(void)showMonitoringController{
    [self hideLoader];
    [[AppDelegate getInstance] showMonitoringController];
}

-(void)getDictionaryFromEntity:(NSArray*)contacts{
    _fetchedContacts = [NSMutableArray new];
    for(Contact *singleContact in contacts){
        [_fetchedContacts addObject:[singleContact getDictionary]];
    }
}

-(void)performSignUpOperationWithEmail:(NSString*)email password:(NSString*)pass andSource:(NSString*)source{
    [self showLoader];
    [service.user userExistInDBofEmail:email withSuccess:^(id response) {
        NSString *status = [response objectForKey:@"value"];
        if([status isEqualToString:@"true"]){
            if([source isEqualToString:@"Facebook"] || [source isEqualToString:@"Google"]){
                [self fetchContactsOfEmail:email];
                return;
            }
            [self hideLoader];
            [Alert show:@"Error" andMessage:@"We are sorry. The login email already exists. Please try different email address to register."];
            [(CreateAccountView*)self.view clearFields];
        }
        else{
            NSLog(@"details need to be inserted");
            User *user = [self createUserEntitywithEmail:email Password:pass andSource:source];
            [service.user insertUser:user withSuccess:^(id response) {
                [UserDefaults saveEmailInUserDefaults:email];
                [self showEmergencyContactsInitialController];
            } andfailure:^(NSError *error) {
                NSLog(@"error:%@",error.localizedDescription);
            }];
            
        }
    } andfailure:^(NSError *error) {
        [self onServiceResponseFailure:error];
    }];
}

-(void)showEmergencyContactsInitialController{
    [self hideLoader];
    EmergencyContactsInitialController *controller = [EmergencyContactsInitialController new];
    [self.navigationController pushViewController:controller animated:YES];
}

-(User*)createUserEntitywithEmail:(NSString*)email Password:(NSString*)pass andSource:(NSString*)source{
    User *user = [User new];
    NSDictionary *userDictionary = @{@"email":email,
                                     @"pwd":pass,
                                     @"source":source};
    [user set:userDictionary];
    return user;
}

@end
