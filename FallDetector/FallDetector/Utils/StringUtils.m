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

+(NSMutableString*)getFirstLetterFromEachWord:(NSString*)sentence{
    int count=0;
    NSString *sentenceWithoutNumbers = [[sentence componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@" "];
    
    NSMutableString * firstCharacters = [NSMutableString string];
    NSArray * words = [sentenceWithoutNumbers componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString * word in words) {
        if(count==2){
            return firstCharacters;
        }
        if ([word length] > 0) {
            NSString * firstLetter = [word substringToIndex:1];
            [firstCharacters appendString:[firstLetter uppercaseString]];
            count++;
        }
    }
    return firstCharacters;
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:candidate];
}

+(NSString *) getUserNameFromEmail:(NSString*)email{
    NSArray *dividedEmail = [email componentsSeparatedByString:@"@"];
    NSString *usernameWithoutNumbers = [[[dividedEmail firstObject] componentsSeparatedByCharactersInSet:
                             [[NSCharacterSet letterCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
    return usernameWithoutNumbers;
}

+(NSString *) getStringFromInt:(int) integer{

    return [NSString stringWithFormat:@"%d", integer];
}

+ (NSString *) stringByTrimmingWhiteSpaces : (NSString *) string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
