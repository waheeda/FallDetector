//
//  Alert.h
//  Guardian
//
//  Created by mohsin on 10/22/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Alert : NSObject

+(void)show:(NSString*)title andMessage:(NSString*)message;
+ (void) show : (NSString *) title andMessage : (NSString *) message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle tag:(NSInteger)tag WithDelegate:(id) delegate;
@end
