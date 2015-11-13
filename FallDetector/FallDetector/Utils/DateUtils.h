//
//  DateUtils.h
//  MBO
//
//  Created by Waheeda on 3/12/15.
//  Copyright (c) 2015 10Pearls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (NSDateComponents *) getDateComponents : (NSDate *) startDate EndDate : (NSDate *) endDate;
+ (NSString *) getDuration : (NSDate *) startDate EndDate : (NSDate *) endDate;
+ (NSString *) formatMinutes : (int) min;
+ (NSDate *) dateFromString : (NSString *) dateString withFormat : (NSString *) format inUTC : (BOOL) utc;
+ (NSDate *) getCurrentDateInUTC;
+ (NSString *) stringFromDate : (NSDate *) date withFormat : (NSString *) format inUTC : (BOOL) utc;
+ (NSDate *) dateByAddingDaysIntoDate : (NSDate *) date Count : (int) daysCount;
+ (NSString *) stringFromDate:(NSDate *) date ;

@end
