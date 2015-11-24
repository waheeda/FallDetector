//
//  LoginView.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "GoogleSignIn/GoogleSignIn.h"
#import "GoogleManager.h"

@interface LoginView : BaseView <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoYConstraint;
- (void)setData:(NSArray*)data;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *yCOnstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *emailCentreConstraint;
@property (strong, nonatomic) IBOutlet UIButton *googleSignIn;

@end
