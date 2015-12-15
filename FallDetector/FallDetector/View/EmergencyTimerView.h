//
//  MatchList.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseView.h"
#import "KAProgressLabel.h"
@interface EmergencyTimerView : BaseView
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *fallDetectionLabel;
@property (strong, nonatomic) IBOutlet UILabel *avgOrientation;
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel;
@property (strong, nonatomic) IBOutlet UIButton *okButton;
-(void)setPLabelText:(int)text;
-(void)setPlabelEndDegree:(CGFloat)degree;
@end
