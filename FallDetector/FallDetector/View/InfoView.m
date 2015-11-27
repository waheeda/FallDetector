//
//  IntroView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/17/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "InfoView.h"
#import "LoginController.h"
#import "IntroController.h"
#import "InfoController.h"
@implementation InfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)onNextButtonClick:(id)sender {
    [(InfoController*)self.controller openIntroController];
}

@end
