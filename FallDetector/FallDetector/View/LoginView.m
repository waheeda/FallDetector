//
//  LoginView.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "LoginView.h"
#import "LoginController.h"

@interface LoginView()

@property (nonatomic, weak) LoginController *controller;

@end

@implementation LoginView
@dynamic controller;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(NSArray*)data{

}

- (IBAction)openRegistrationController:(id)sender {

    [self.controller openRegistrationController];
    
}


@end