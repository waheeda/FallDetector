//
//  MatchList.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "EmergencyTimerView.h"
#import "Color.h"
#import "EmergencyTimerController.h"
@implementation EmergencyTimerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [self createCircularTimerLabel];
    

}
- (IBAction)okButtonClick:(id)sender {
    [(EmergencyTimerController*)self.controller popViewController];
}

-(void)setOkButtonCornerRadius{
    self.okButton.layer.cornerRadius = self.okButton.frame.size.width/2; // this value vary as per your desire
    self.okButton.clipsToBounds = YES;
}

-(void)createCircularTimerLabel{
    [self setCircularTimerProperties];
    [self setOkButtonCornerRadius];
    __unsafe_unretained EmergencyTimerView * weakSelf = self;
    self.pLabel.labelVCBlock = ^(KAProgressLabel *label) {
        weakSelf.pLabel.startLabel.text = [NSString stringWithFormat:@"%.f",weakSelf.pLabel.startDegree];
        weakSelf.pLabel.endLabel.text = [NSString stringWithFormat:@"%.f",weakSelf.pLabel.endDegree];
    };
}

- (void)setCircularTimerProperties {
    self.pLabel.backgroundColor = [UIColor clearColor];
    [self.pLabel setProgressWidth: 28.2];
    [self.pLabel setTrackWidth: 28];
    self.pLabel.fillColor = [Color greyBackgroundColor];
    self.pLabel.trackColor = [Color orangeThemeColor];
    self.pLabel.progressColor = [Color greyThemeColor];
    self.pLabel.isStartDegreeUserInteractive = YES;
    self.pLabel.isEndDegreeUserInteractive = YES;
}

-(void)setPLabelText:(int)text{
    [self.pLabel setText:[NSString stringWithFormat:@"%d",text]];
}

-(void)setPlabelEndDegree:(CGFloat)degree{
    [self.pLabel setEndDegree:degree];
}

@end
