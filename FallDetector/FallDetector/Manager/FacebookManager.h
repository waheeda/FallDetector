//
//  FacebookManager.h
//  DeadRinger
//
//  Created by Waheeda on 10/7/15.
//  Copyright (c) 2015 DeadRinger. All rights reserved.
//


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Foundation/Foundation.h>

typedef void (^FBMCallback)(id result, NSError *error);

@protocol FacebookManagerDelegate <NSObject>
@optional
-(void) onFacebookLogin:(id) result;
-(void) onFacebookLogout;
-(void) onLoginCancelled;

@end


@interface FacebookManager : NSObject

@property(nonatomic, weak) id <FacebookManagerDelegate> loginDelegate;

+ (FacebookManager *)instance;
+(void)logoutFromFacebook;
+ (void)loginWithViewController:(UIViewController*)controller andCallback:(FBMCallback)callback;
+ (void)fetchUserInfo:(FBMCallback)callback;
+ (void)clearAccessToken;
+ (BOOL) isLoggedIn ;
+(NSString *) getProfilePicURL;
+(NSString *) getAccesstoken;
@end
