//
//  BaseController.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"

@interface BaseController : UIViewController <UIAlertViewDelegate>{
    Service *service;
}

-(void)loadServices:(NSArray*)services;
-(void)setupNavBar;
-(void)showLoader;
-(void)showLoader:(NSString*)message;
-(void)hideLoader;
-(void)onServiceResponseFailure:(NSError*)error;
-(void)popToViewController:(NSString *)viewController;
-(void)pushViewController:(UIViewController *)controller;
-(void)popViewController;
-(void)showLoaderOnUIView:(UIView*) view;
-(void) setRootViewController:(UIViewController *)controller;
-(UIBarButtonItem *) createBackButton:(id)target selector:(SEL)selector ;
-(UIBarButtonItem*)createLeftMenuButton;
-(void) showLogoutAlert;
-(void)hideLoaderOnUIView:(UIView*)view;
-(void)showContactsNotFoundAlert;
-(void)fetchContacts;
@end
