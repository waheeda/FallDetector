//
//  AboutView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 12/4/15.
//  Copyright © 2015 Muhammad Hamiz Ahmed. All rights reserved.
//

#import "AboutView.h"
#import "AboutController.h"
@implementation AboutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)backButtonClick:(id)sender {
    [(AboutController*)self.controller popViewController];
}

@end
