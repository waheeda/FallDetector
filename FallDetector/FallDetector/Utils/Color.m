//
//  Color.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "Color.h"

@implementation Color

+(UIColor*)backgroundColor{
    return [UIColor whiteColor];
}

+(UIColor*)orangeThemeColor{
    return [UIColor colorWithRed:249/255.0f green:146/255.0f blue:10/255.0f alpha:1.0f];
}

+(UIColor*)greyThemeColor{
    return [UIColor colorWithRed:101/255.0f green:101/255.0f blue:101/255.0f alpha:1.0f];
}

+(UIColor*)greyBackgroundColor{
    return [UIColor colorWithRed:78/255.0f green:78/255.0f blue:78/255.0f alpha:1.0f];
}
@end
