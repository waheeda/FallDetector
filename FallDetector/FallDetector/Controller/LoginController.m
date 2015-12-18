//
//  LoginController.m
//  iOSTemplate
//
//  Created by Muhammad Hamiz Ahmed on 4/3/14.
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
#import "DashboardController.h"
#import "InfoController.h"
#import "MenuController.h"
#import "AppDelegate.h"
#import "ContactsResponse.h"
#import "Contact.h"
#import "Alert.h"
#import "EmergencyContactsInitialController.h"
#import "ForgotPasswordController.h"

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
    [super loadServices:@[@(ServiceTypeContacts),@(ServiceTypeUser),@(ServiceTypeAuth)]];
}

-(void)viewWillAppear:(BOOL)animated{
   
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

-(void)authenticateUser:(NSString*)email andPassword:(NSString*)pass{
    [self showLoader];
    [service.auth authenticateWithEmail:email andPassword:pass withSuccess:^(id response){
        NSString *status = [response objectForKey:@"status"];
        if([status isEqualToString:@"true"]){
            NSLog(@"Login Successful");
            [self fetchContactsOfEmail:email];
        }
        else{
            [self hideLoader];
            [Alert show:@"Login Failed" andMessage:@"Invalid Email or Password"];
        }
    } andfailure:^(NSError *error) {
        NSLog(@"Failure");
        [super onServiceResponseFailure:error];
    }];
}

-(void)getDictionaryFromEntity:(NSArray*)contacts{
    _fetchedContacts = [NSMutableArray new];
    for(Contact *singleContact in contacts){
        [_fetchedContacts addObject:[singleContact getDictionary]];
    }
}

-(void)performLoginOperationWithEmail:(NSString*)email andSource:(NSString*)source{
    [service.user userExistInDBofEmail:email withSuccess:^(id response) {
        NSString *status = [response objectForKey:@"value"];
        if([status isEqualToString:@"true"]){
            [self fetchContactsOfEmail:email];
        }
        else{
            NSLog(@"details need to be inserted");
            User *user = [self createUserEntitywithEmail:email Password:@"" andSource:source];
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



//changes
-(void)loginFromFacebook{
    [self showLoaderOnUIView:self.view];
    [FacebookManager loginWithViewController:self andCallback:^(id result, NSError *error) {
        if([result valueForKey:@"isCancelled"]){
            [self hideLoaderOnUIView:self.view];
            [Alert show:@"Login Failed" andMessage:@"Login operation cancelled"];
        }
        
        else if([result valueForKey:@"email"]){
             [self performLoginOperationWithEmail:[result valueForKey:@"email"] andSource:@"Facebook"];
        }
        
        else{
            [self onServiceResponseFailure:error];
        }
    }];
}

-(void)insertUserDetailsWithSource:(NSString*)source{
    
}

-(User*)createUserEntitywithEmail:(NSString*)email Password:(NSString*)pass andSource:(NSString*)source{
    User *user = [User new];
    NSDictionary *userDictionary = @{@"email":email,
                                     @"pwd":pass,
                                     @"source":source};
    [user set:userDictionary];
    return user;
}

-(void)loginFromGoogle{
    [self showLoader];
    [GoogleManager signIn];
}

//Delegate Methods
-(void)onGoogleSignInWithEmail:(NSString *)email{
   [self performLoginOperationWithEmail:email andSource:@"Google"];
    //[self showEmergencyContactsInitialController];
}

-(void)onSignInError:(NSError*)error{
    [self hideLoader];
    [Alert show:@"Login Failed" andMessage:@"Login operation cancelled"];
}

-(void)showMonitoringController{
    [self hideLoader];
    [[AppDelegate getInstance] showMonitoringController];
}

-(void)showForgotPasswordController{
    ForgotPasswordController* controller = [ForgotPasswordController new];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)showEmergencyContactsInitialController{
    [self hideLoader];
    EmergencyContactsInitialController *controller = [EmergencyContactsInitialController new];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)presentGoogleViewController:(UIViewController*) controller{
    [self hideLoader];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)dismissGoogleViewController:(UIViewController*) controller{
    [self showLoader];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
