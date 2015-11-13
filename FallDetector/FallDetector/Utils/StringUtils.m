//
//  StringUtils.m
//  Guardian
//
//  Created by mohsin on 10/17/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+(BOOL)isEmptyOrNull:(NSString*)value{
    if([value isKindOfClass:[NSNull class]] || value.length == 0)
        return YES;
    
    return NO;
}

+(NSString*)validateForNull:(NSString*)value{
    if([self isEmptyOrNull:value])
        return nil;
    
    return value;
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:candidate];
}


+(NSString *) getStringFromInt:(int) integer{

    return [NSString stringWithFormat:@"%d", integer];
}

@end
