//
//  AppDelegate.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "CreateAccountController.h"
#import "MatchListController.h"
#import "InfoController.h"
#import "MonitoringController.h"
#import "MenuController.h"
#import "UserDefaults.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *kClientID = @"936951329577-6r2kvgjhsmf6tbvmu7e36ah59uv4ccuc.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].clientID = kClientID;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.navigationController = [[UINavigationController alloc] init];
    [self.window setRootViewController:self.navigationController];
    
    if([UserDefaults isLoggedIn]) {
        [self showMonitoringController];
    }
    else{
        [self showInfoController];
    }
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    BOOL returnValue = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                didFinishLaunchingWithOptions:launchOptions];
    return returnValue;
}

+(AppDelegate*)getInstance{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

-(void)showInfoController{
    if([self.navigationController.topViewController isKindOfClass:[InfoController class]])
        return;
    InfoController* infoController = [[InfoController alloc] init];
    [self.navigationController setViewControllers:@[infoController] animated:YES];
}


-(void)showMonitoringController{
    MonitoringController *monitoringController = [[MonitoringController alloc] init];
    MenuController *menuController = [[MenuController alloc] init];
    
    self.homeNavigationController = [[UINavigationController alloc] initWithRootViewController:monitoringController];
    [self setCenterController:self.homeNavigationController leftMenuViewController:menuController rightViewController:nil];
}



-(void)setCenterController:(id)centerViewController
    leftMenuViewController:(id)leftMenuViewController
       rightViewController:(id)rightViewController{
    _sideMenuContainer = [MFSideMenuContainerViewController
                          containerWithCenterViewController:centerViewController
                          leftMenuViewController:leftMenuViewController
                          rightMenuViewController:rightViewController];
    
    [self.navigationController setViewControllers:@[_sideMenuContainer]];
}

-(MFSideMenuContainerViewController*)getMenuContainer{
    return _sideMenuContainer;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    NSString *fbURL = @"fb1713892102172775";
    if([[url absoluteString] containsString:fbURL])
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
    else
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];
}

@end
