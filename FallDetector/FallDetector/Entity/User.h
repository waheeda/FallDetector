//
//  User.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface User : BaseEntity

@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString *source;
-(void)set:(NSDictionary*)input;
@end
