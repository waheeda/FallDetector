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
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *kClientID = @"936951329577-6r2kvgjhsmf6tbvmu7e36ah59uv4ccuc.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].clientID = kClientID;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /*MatchListController *c = [[MatchListController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:c];*/
    /*LoginController *c = [[LoginController alloc] init];
     UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:c];*/
    InfoController *c = [[InfoController alloc] init];
    
    BOOL returnValue = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                didFinishLaunchingWithOptions:launchOptions];
   
   
    
//    NSError* configureError;
//    [[GGLContext sharedInstance] configureWithError: &configureError];
//    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
 //   [GIDSignIn sharedInstance].uiDelegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:c];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    
    //[[GIDSignIn sharedInstance] setScopes:[NSArray arrayWithObject:@"https://www.googleapis.com/auth/plus.login"]];
    // [GIDSignIn sharedInstance].delegate = self;
    
    return returnValue;
}

+(AppDelegate*)getInstance{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
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

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *name = user.profile.name;
    NSString *email = user.profile.email;
    // ...
}

@end
