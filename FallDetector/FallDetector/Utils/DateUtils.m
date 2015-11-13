//
//  DateUtils.m
//  MBO
//
//  Created by Waheeda on 3/12/15.
//  Copyright (c) 2015 10Pearls. All rights reserved.
//

#import "DateUtils.h"
#import "StringUtils.h"
#import "Constant.h"

@implementation DateUtils

+ (NSDateComponents *) getDateComponents : (NSDate *) startDate EndDate : (NSDate *) endDate {
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];

    unsigned int unitFlags = NSCalendarUnitMinute | NSCalendarUnitSecond;

    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:startDate toDate:endDate options:0];

    return conversionInfo;
}

+ (NSString *) getDuration : (NSDate *) startDate EndDate : (NSDate *) endDate {
    NSDateComponents *conversionInfo = [DateUtils getDateComponents:startDate EndDate:endDate];

    return [DateUtils formatMinutes:(int)[conversionInfo minute]];
}

+ (NSString *) formatMinutes : (int) min {
    if (min < 0) {
        min = (-1) * min;
    }

    int hrs =  min / 60;

    if (hrs == 0) {
        return [NSString stringWithFormat:@"%%[%d]%% min%@", min, [StringUtils getStringFromInt:min]];
    }

    if (hrs < 24) {
        return [NSString stringWithFormat:@"%%[%d]%% hr%@", hrs, [StringUtils getStringFromInt:hrs]];
    }

    int days = hrs / 24;

    if (days < 31) {
        return [NSString stringWithFormat:@"%%[%d]%% day%@", days, [StringUtils getStringFromInt:days]];
    }

    int month = days / 30;

    if (month < 12) {
        return [NSString stringWithFormat:@"%%[%d]%% month%@", month, [StringUtils getStringFromInt:month]];
    }

    int year = month / 12;
    return [NSString stringWithFormat:@"%%[%d]%% year%@", year, [StringUtils getStringFromInt:year]];
}

+ (NSDate *) dateFromString : (NSString *) dateString withFormat : (NSString *) format inUTC : (BOOL) utc {
    if (dateString == nil) {
        return nil;
    }

    NSDate *date = [NSDate date];

    if ([dateString isKindOfClass:[NSNull class]]) {
        return date;
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];

    if (utc) {
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
    }
    date = [dateFormatter dateFromString:dateString];
    return date;
}

+ (NSDate *) getCurrentDateInUTC {
    NSDate *date = [NSDate date];
    return date;
}

+ (NSString *) stringFromDate : (NSDate *) date withFormat : (NSString *) format inUTC : (BOOL) utc {
    NSString *dateString           = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    if (format) {
        [dateFormatter setDateFormat:format];
    } else {
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDoesRelativeDateFormatting:YES];
    }

    if (utc) {
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
    }
    dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *) stringFromDate:(NSDate *) date {

    return [DateUtils stringFromDate:date withFormat:DATE_FORMAT inUTC:NO];

}



+ (NSDate *) dateByAddingDaysIntoDate : (NSDate *) date Count : (int) daysCount {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    components.hour = daysCount;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return newDate;
}







@end
