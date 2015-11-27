//
//  Utils.m
//  Yuru
//
//  Created by Waheeda on 5/30/13.
//  Copyright (c) 2013 Ali Zohair. All rights reserved.
//

#import "Utils.h"
#import "Font.h"
#define IMAGE_BG_BAR_BUTTON  @"CheckBox_Deselected.png"
#define IMG_BACK    @"CheckBox_Selected.png"

@implementation Utils

+ (BOOL) isNull : (id) object {
	return (object == nil ||  [object isKindOfClass:[NSNull class]] );
}

+ (id) validateNilObject : (id) object {
	if ([Utils isNull:object]) {
		return nil;
	}
	return object;
}


//+(void) setUISwitchAppearance
//{
//    
//    [[UISwitch appearance] setOnTintColor:LIGHT_BLUE_COLOR];
//    
//    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
//    {
//        [[UISwitch appearance] setTintColor:GRAY_COLOR_WITH_VALUE(104)];
//        [[UISwitch appearance] setThumbTintColor:GRAY_COLOR_WITH_VALUE(180)];
//    }
//}
//
//+ (NSURL *)applicationDocumentsDirectory
//{
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//}
//
//
+(NSArray *) getSortedArray:(NSArray *)array  withKey:(NSString *) key  ascending:(BOOL) isAscending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                  ascending:isAscending] ;
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return  [array sortedArrayUsingDescriptors:sortDescriptors];
}

//+ (NSDate *) dateFromString : (NSString *) dateString
//{
//    return  [Utils dateFromString:dateString withFormat:DATE_FORMAT_NORMAL isUTC:YES];
//}
//
//
//+ (NSDate *) dateFromString : (NSString *) dateString withFormat : (NSString *) format isUTC:(BOOL)utc{
//
//	if (dateString == nil) {
//		return nil;
//	}
//    
//	NSDate *date = [NSDate date];
//    
//	if ([dateString isKindOfClass:[NSNull class]]) {
//		return date;
//	}
//    
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	[dateFormatter setDateFormat:format];
//    if(utc)
//    {
//        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//        [dateFormatter setTimeZone:timeZone];
//    }
//	
//	date = [dateFormatter dateFromString:dateString];
//	return date;
//}
//
//+ (NSString *) stringFromDate : (NSDate *) date withFormat : (NSString *) format
//{
//    return [Utils stringFromDate:date withFormat:format isUTC:YES];
//}
//
//+ (NSString *) stringFromDate : (NSDate *) date withFormat : (NSString *) format isUTC:(BOOL)utc {
//
//    NSString *dateString           = @"";
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    if(utc)
//    {
//        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//        [dateFormatter setTimeZone:timeZone];
//    }
//    
//	if (format) {
//		[dateFormatter setDateFormat:format];
//	}
//
//    
//	dateString = [dateFormatter stringFromDate:date];
//	return dateString;
//}
//
//+(NSDate *) getDateByAdding:(NSString *) _duration // Possible formats 1 hour(s), 1 day, 1 month, 1 year,
//{
//    NSArray *duration = [_duration componentsSeparatedByString:@" "];
//    NSDate* newDate = nil;
//    if(duration.count > 1)
//    {
//        
//        NSCalendar*       calendar = [NSCalendar currentCalendar] ;
//        NSDateComponents* components = [[NSDateComponents alloc] init] ;
//        NSDate *date = [NSDate date];
//        int value = [[duration objectAtIndex:0] intValue];
//        NSString *unit = [duration objectAtIndex:1];
//        unit = [[unit stringByReplacingOccurrencesOfString:@"s" withString:@""] lowercaseString];
//        
//        if([unit isEqualToString:@"day"])
//            components.day = value;
//        else if([unit isEqualToString:@"hour"])
//            components.hour = value;
//        else if([unit isEqualToString:@"month"])
//            components.month = value;
//        else if([unit isEqualToString:@"year"])
//            components.year = value;
//        
//        newDate = [calendar dateByAddingComponents: components toDate: date options: 0];
//    }
//    
//    return newDate;
//}

+ (UIBarButtonItem *)getBarButtonItemWithTarget:(id)target andSelector:(SEL)selector title:(NSString *)title {
    
    UIFont *titleFont = [Font normal];
    
    CGSize titleSize = [title sizeWithFont:titleFont];
    titleSize.width += 15;
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:IMAGE_BG_BAR_BUTTON] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:titleFont];
    [button.titleLabel setTextColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, titleSize.width, 59/2)];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:IMG_BACK] style:UIBarButtonItemStyleBordered target:target action:selector];
}


//+ (NSDateComponents *) getDateComponents : (NSDate *) startDate EndDate : (NSDate *) endDate {
//	NSCalendar *sysCalendar = [NSCalendar currentCalendar];
//    
//	unsigned int unitFlags = NSMinuteCalendarUnit| NSSecondCalendarUnit;
//    
//	NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:startDate toDate:endDate options:0];
//    
//	return conversionInfo;
//}
//
//+ (NSString *) getDuration : (NSDate *) startDate EndDate : (NSDate *) endDate {
//	NSDateComponents *conversionInfo = [Utils getDateComponents:startDate EndDate:endDate];
//    
//	return [Utils formatMinutes:[conversionInfo minute]];
//}
//
//+ (NSString *) formatMinutes : (int) min {
//	if (min < 0) {
//		min = (-1) * min;
//	}
//    
//	int hrs =  roundf(min / 60.0);
//    
//	if (hrs == 0) {
//		return [NSString stringWithFormat:@"%d minute%@", min, [StringHelper getString:min]];
//	}
//    
//	if (hrs < 24) {
//		return [NSString stringWithFormat:@"%d hour%@", hrs, [StringHelper getString:hrs]];
//	}
//    
//	int days = hrs / 24;
//    
//	if (days < 31) {
//		return [NSString stringWithFormat:@"%d day%@", days, [StringHelper getString:days]];
//	}
//    
//	int month = days / 30;
//    
//	if (month < 12) {
//		return [NSString stringWithFormat:@"%d month%@", month, [StringHelper getString:month]];
//	}
//    
//	int year = month / 12;
//	return [NSString stringWithFormat:@"%d year%@", year, [StringHelper getString:year]];
//}
//
//
//+ (NSString *) trim:(NSString *)string {
//    
//    NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    return trimmedString;
//}
//
//+ (BOOL) isValidEmailAddressWithValue:(NSString *)emailAddress {
//    
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:emailAddress];
//}
//
//+ (BOOL) isValidPhoneNumberWithValue:(NSString *)phoneNumber {
//	
//	NSString *regExPattern = @"[0-9]{10}";
//    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
//    NSUInteger regExMatches = [regEx numberOfMatchesInString:phoneNumber options:0 range:NSMakeRange(0, [phoneNumber length])];
//	
//    if (regExMatches == 0) {
//        return NO;
//    } else {
//		if (phoneNumber.length == 10)
//			return YES;
//		else {
//			return NO;
//		}
//	}
//}
//
//+ (BOOL) isValidNameWithValue:(NSString *)name {
//	
//	NSString *regExPattern = @"^[A-Z]+$";
//    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
//    NSUInteger regExMatches = [regEx numberOfMatchesInString:name options:0 range:NSMakeRange(0, [name length])];
//	
//	
//    if (regExMatches == 0) {
//        return NO;
//    } else
//        return YES;
//}
//
//+ (void) openBrowserWithUrl:(NSString *)urlString {
//
//	NSURL *url = [NSURL URLWithString:urlString];
//	[[UIApplication sharedApplication] openURL:url];
//}
//
//+ (NSString *) getApplicationVersion {
//
//	NSString *versionString = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//	return versionString;
//}
//
//+ (NSString *) getCurrentDateTime {
//	
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	[dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss:SSS"];
//	return [dateFormatter stringFromDate:[NSDate date]];
//}
//
//+ (int) getBatteryLevel {
//	
//	NSNumber *percent = [[NSNumber alloc]initWithDouble:[[UIDevice currentDevice] batteryLevel] * 100];
//	return [percent integerValue];
//}
//
//+ (NSString *) getTodaysDate {
//	
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
//	
//	NSString *formattedDateString = [dateFormatter stringFromDate:[NSDate date]];
//	return formattedDateString;
//}

@end
