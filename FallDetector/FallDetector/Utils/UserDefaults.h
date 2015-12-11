//
//  UserDefaults.h
//  DeadRinger
//
//  Created by Muhammad Hamiz Ahmed on 10/5/15.
//  Copyright © 2015 DeadRinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class AuthResponse;

@interface UserDefaults : NSObject
+(void)setPlaceMark:(CLPlacemark*)placeMark;
+(CLPlacemark*)getPlaceMark;
+(void)removePlaceMark;
+ (void)setAuthResponse:(AuthResponse *)authResponse;
+ (AuthResponse *) getAuthResponse;
+(void)setFacebookUserID:(NSString *)userID;
+(void)clearUserDefaults;
+(void)setFBFullName:(NSString *)name;
+(NSString *)getFacebookUserID;
+(NSString*)getFBFullName;
+(void) setIsOnboardingCompleted:(BOOL) isCompleted;
+(void)setEmergencyContacts:(NSMutableArray*)contacts;
+(NSMutableArray*)getEmergencyContacts;
+(void)saveEmailInUserDefaults:(NSString*)email;
+(BOOL)isLoggedIn;
+(NSString*)getEmail;
+(void)clearEmergencyContacts;
@end
