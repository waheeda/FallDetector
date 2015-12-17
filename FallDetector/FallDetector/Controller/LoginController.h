//
//  LoginController.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "FacebookManager.h"
#import "GoogleManager.h"
#import "MFSideMenuContainerViewController.h"
@interface LoginController : BaseController <GoogleManagerDelegate>{
    NSMutableArray *_fetchedContacts;
}
-(void)loginFromFacebook;
-(void)loginFromGoogle;
-(void)authenticateUser:(NSString*)email andPassword:(NSString*)pass;
@property (strong, nonatomic) UINavigationController *homeNavigationController;
@property (strong, nonatomic) MFSideMenuContainerViewController *sideMenuContainer;
@end
