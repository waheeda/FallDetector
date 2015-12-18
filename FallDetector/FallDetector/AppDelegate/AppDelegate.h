//
//  AppDelegate.h
//  iOSTemplate
//
//  Created by Muhammad Hamiz Ahmed on 4/3/14.
//  Copyright (c) 2014 Muhammad Hamiz Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "MFSideMenuContainerViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    MFSideMenuContainerViewController *_sideMenuContainer;
}
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UINavigationController *homeNavigationController;
@property (strong, nonatomic) UIWindow *window;
+(AppDelegate*)getInstance;
-(void)showMonitoringController;
-(MFSideMenuContainerViewController*)getMenuContainer;
@end
