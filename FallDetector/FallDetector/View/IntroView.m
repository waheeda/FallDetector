//
//  IntroView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/17/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "IntroView.h"
#import "LoginController.h"
@implementation IntroView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)onNextButtonClick:(id)sender {
    LoginController *controller =[[LoginController alloc] init];
    [[self.controller navigationController] pushViewController:controller animated:YES];
}

@end
