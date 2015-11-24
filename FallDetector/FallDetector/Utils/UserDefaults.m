//
//  UserDefaults.m
//  DeadRinger
//
//  Created by Muhammad Hamiz Ahmed on 10/5/15.
//  Copyright © 2015 DeadRinger. All rights reserved.
//

#import "UserDefaults.h"
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define KEY_USERDEFAULTS_FB_USER_ID         @"FB_USERID"
#define KEY_USERDEFAULTS_FB_FULL_NAME         @"FB_FULLNAME"
#define KEY_USERDEFAULTS_PLACEMARK  @"PLACEMARK"
#define KEY_USERDEFAULTS_AUTH_RESPONSE          @"DEADRINGER_AUTH_RESPONSE"
#define KEY_USERDEFAULTS_IS_ONBOARDING_COMPLETED         @"IS_ONBOARDING_COMPLETED"

@implementation UserDefaults


+ (void)setAuthResponse:(AuthResponse *)authResponse{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:authResponse];
    [USER_DEFAULTS setObject:data forKey:KEY_USERDEFAULTS_AUTH_RESPONSE];
    [USER_DEFAULTS synchronize];
    
}

+ (AuthResponse *) getAuthResponse {
    if ([USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_AUTH_RESPONSE]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_AUTH_RESPONSE]];
    }
    return nil;
    
}


+(void)removePlaceMark{
    if ([USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_PLACEMARK]){
        [USER_DEFAULTS removeObjectForKey:KEY_USERDEFAULTS_PLACEMARK];
        [USER_DEFAULTS synchronize];
    }
}

+(void)setPlaceMark:(CLPlacemark*)placeMark{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:placeMark];
    [USER_DEFAULTS setObject:data forKey:KEY_USERDEFAULTS_PLACEMARK];
    [USER_DEFAULTS synchronize];
}

+(CLPlacemark*)getPlaceMark{
    if ([USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_PLACEMARK]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_PLACEMARK]];
    }
    return nil;
    
}


+(void)setFacebookUserID:(NSString *)userID{

    [USER_DEFAULTS setObject:userID forKey:KEY_USERDEFAULTS_FB_USER_ID];
    [USER_DEFAULTS synchronize];
}

+(void)clearUserDefaults{
    [UserDefaults setFacebookUserID:nil];
}

+(void)setFBFullName:(NSString *)name{
    [USER_DEFAULTS setObject:name forKey:KEY_USERDEFAULTS_FB_FULL_NAME];
    [USER_DEFAULTS synchronize];

}

+(NSString *)getFacebookUserID{
    if([USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_FB_USER_ID]) {
        return [USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_FB_USER_ID];
    }
    return nil;

}

+(NSString*)getFBFullName{
    if([USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_FB_FULL_NAME]) {
        return [USER_DEFAULTS objectForKey:KEY_USERDEFAULTS_FB_FULL_NAME];
    }
    return nil;
}

+(void) setIsOnboardingCompleted:(BOOL) isCompleted {

    [USER_DEFAULTS setBool:isCompleted forKey:KEY_USERDEFAULTS_IS_ONBOARDING_COMPLETED];
}

+(BOOL) isOnboardingCompleted {

    return [USER_DEFAULTS boolForKey:KEY_USERDEFAULTS_IS_ONBOARDING_COMPLETED];
}




@end