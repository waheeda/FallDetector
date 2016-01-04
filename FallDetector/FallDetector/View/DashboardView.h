//
//  MonitoringView.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/23/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"

@interface DashboardView : BaseView
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
-(void)setUsernameLabelText:(NSString*)username;
@end
