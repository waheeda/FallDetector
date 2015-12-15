//
//  MonitoringView.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/23/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "DashboardView.h"
#import "DashboardController.h"
@implementation DashboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)startMonitoringClick:(id)sender {
    [(DashboardController*)self.controller startFetchingLocation];
}


@end
