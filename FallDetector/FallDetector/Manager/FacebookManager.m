//
//  FacebookManager.m
//  DeadRinger
//
//  Created by Waheeda on 10/7/15.
//  Copyright (c) 2015 DeadRinger. All rights reserved.
//


#import "FacebookManager.h"
#import "Constant.h"
#import "Alert.h"
#import "UserDefaults.h"


@interface FacebookManager () 

@end


@implementation FacebookManager

+ (FacebookManager *)instance {
    static FacebookManager *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[FacebookManager alloc] init];
    });
    return sharedInstance;
}


#pragma mark - Internal Methods

+(BOOL) isLoggedIn {

    return ([FBSDKAccessToken currentAccessToken] != nil );
}

+(NSString *) getAccesstoken {

    return [[FBSDKAccessToken currentAccessToken] tokenString];
}

+(NSString *) getProfilePicURL {

    NSString *profilePicURL=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&width=300&height=300", [UserDefaults getFacebookUserID]];
    return profilePicURL;
}
// For custom login button

+(void)logoutFromFacebook{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
}


+ (void)loginWithViewController:(UIViewController*)controller andCallback:(FBMCallback)callback
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] fromViewController:controller handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            callback(nil, error);
            return;
        }
        
        callback(result, nil);
    }];
}

+ (void)fetchFBFromQuery:(NSString*)query parameters:(NSDictionary*)params withCallback:(FBMCallback)callback
{
    FBSDKGraphRequestHandler handler = ^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        callback(result, error);
    };
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:query parameters:params] startWithCompletionHandler:handler];
        return;
    }
    
    [FacebookManager loginWithViewController:nil andCallback:^(id result, NSError *error) {
        if (error) {
            callback(nil, error);
            return;
        }
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:query parameters:params] startWithCompletionHandler:handler];
    }];
}
//
+ (void)clearAccessToken
{
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [FBSDKProfile setCurrentProfile:nil];
}
//
//
//#pragma mark - Fetch Methods
//
+ (void)fetchUserInfo:(FBMCallback)callback
{
    [FacebookManager fetchFBFromQuery:@"me" parameters:nil withCallback:^(id result, NSError *error) {
        [FacebookManager saveUserInfo:result];
        callback(result, error);
        
    }];
}
//
+(void)saveUserInfo:(id) result{
    NSString *fullName;
    NSString *lastName;
    NSString *fbName=[result valueForKey:@"name"];
    NSArray *nameArray = [fbName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *firstName =[nameArray objectAtIndex:0];
    if(nameArray.count>1){
        lastName =[nameArray objectAtIndex:1];
        fullName = [firstName stringByAppendingFormat:@" %@.",[lastName substringWithRange:NSMakeRange(0, 1)]];
    }
    else
        fullName = firstName;
    [UserDefaults setFacebookUserID:[result valueForKey:@"id"]];
    [UserDefaults setFBFullName:fullName];
}
//
//+ (void)fetchFriendListFrom:(NSInteger)offset to:(NSInteger)limit withCallback:(FBMCallback)callback
//{
//    NSDictionary *parameters = @{
//                                 @"offset": @(offset),
//                                 @"limit" : @(limit)
//                                 };
//
//    [FacebookManager fetchFBFromQuery:@"me/friends" parameters:parameters withCallback:callback];
//}
//
//
//
///* LOGIN BUTTON DELEGATE */
//
//
//- (void)loginButton:(FBSDKLoginButton *)loginButton
//didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
//              error:(NSError *)error {
//
//    if(result.isCancelled)
//        return;
//    if(self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(onFacebookLogin:)])
//        [self.loginDelegate onFacebookLogin:result];
//
//}
//- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
//
//    if(self.loginDelegate && [self.loginDelegate respondsToSelector:@selector(onFacebookLogout)])
//        [self.loginDelegate onFacebookLogout];
//    
//}
//

@end
