//
//  GoogleManager.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/24/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "GoogleManager.h"
#import "UserDefaults.h"
@implementation GoogleManager



+ (GoogleManager *)instance {
    static GoogleManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GoogleManager alloc] init];
    });
    return sharedInstance;
}

-(id)init{
    self=[super init];
    if(self)
    {
        GIDSignIn *signIn = [GIDSignIn sharedInstance];
        signIn.shouldFetchBasicProfile = YES;
        signIn.delegate = self;
        signIn.uiDelegate = self;
    }
    return self;
}


+(void)signIn{
    [[GIDSignIn sharedInstance] signIn];
}

-(void)signOut{
    [[GIDSignIn sharedInstance] signOut];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error) {
        NSLog(@"%@",[NSString stringWithFormat:@"Status: Authentication error: %@", error]);
        [self.delegate onSignInError:(NSError*)error];
        return;
    }
    NSLog(@"Signed In");
    NSLog(@"Email:%@ ",[user.profile email]);
    //[UserDefaults saveEmailInUserDefaults:[user.profile email]];
    [self.delegate onGoogleSignInWithEmail:[user.profile email]];
}

//GID SignInDelegate Methods

- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self.delegate dismissGoogleViewController:viewController];
}

- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self.delegate presentGoogleViewController:viewController];
}


@end
