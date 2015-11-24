//
//  GoogleManager.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/24/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleSignIn/GoogleSignIn.h"
@protocol GoogleManagerDelegate <NSObject >
-(void) presentGoogleViewController:(UIViewController*) controller;
-(void) dismissGoogleViewController:(UIViewController*) controller;
-(void) onGoogleSignIn;
@end
@interface GoogleManager : NSObject <GIDSignInDelegate, GIDSignInUIDelegate>
@property(nonatomic, weak) id<GoogleManagerDelegate> delegate;
+(GoogleManager*)instance ;
+(void)signIn;
@end
