//
//  Utils.h
//  Yuru
//
//  Created by Waheeda on 5/30/13.
//  Copyright (c) 2013 Ali Zohair. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"


@interface Utils : NSObject

/*+ (NSArray *) getSortedArray:(NSArray *)array  withKey:(NSString *) key  ascending:(BOOL) isAscending;

+ (NSDate *) dateFromString : (NSString *) dateString;

+ (NSDate *) dateFromString : (NSString *) dateString withFormat : (NSString *) format isUTC:(BOOL)utc;

+ (NSString *) stringFromDate : (NSDate *) date withFormat : (NSString *) format;*/

+ (UIBarButtonItem *)getBarButtonItemWithTarget:(id)target andSelector:(SEL)selector title:(NSString *)title;
+(NSArray *) getSortedArray:(NSArray *)array  withKey:(NSString *) key  ascending:(BOOL) isAscending;
/*+ (NSDate *) getDateByAdding:(NSString *) _duration;

+ (NSDateComponents *) getDateComponents : (NSDate *) startDate EndDate : (NSDate *) endDate;

+ (NSString *) getDuration : (NSDate *) startDate EndDate : (NSDate *) endDate;

+ (NSString *) formatMinutes : (int) min;

+ (NSURL *)applicationDocumentsDirectory;

+ (BOOL) isNull : (id) object;

+ (id) validateNilObject : (id) object ;

+(void) setUISwitchAppearance;

+ (NSString *) trim:(NSString *)string;
+ (BOOL) isValidEmailAddressWithValue : (NSString *) emailAddress;
+ (BOOL) isValidPhoneNumberWithValue : (NSString *) phoneNumber;
+ (BOOL) isValidNameWithValue : (NSString *) name;

+ (void) openBrowserWithUrl : (NSString *) urlString;
+ (NSString *) getApplicationVersion;
+ (NSString *) getCurrentDateTime;
+ (NSString *) getTodaysDate;
+ (int) getBatteryLevel;*/

@end
