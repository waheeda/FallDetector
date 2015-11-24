//
//  LoginController.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "FacebookManager.h"
#import "GoogleManager.h"
@interface LoginController : BaseController <GoogleManagerDelegate>
-(void)loginFromFacebook;
-(void)loginFromGoogle;
@end
