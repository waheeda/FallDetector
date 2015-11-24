//
//  MatchList.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MatchListView.h"
#import "Color.h"
#import "MatchListController.h"
@implementation MatchListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [self createCircularTimerLabel];
    [self createTimer];

}
- (IBAction)okButtonClick:(id)sender {
    [(MatchListController*)self.controller popViewController];
}

-(void)createCircularTimerLabel{
    self.pLabel.backgroundColor = [UIColor clearColor];
    self.okButton.layer.cornerRadius = self.okButton.frame.size.width/2; // this value vary as per your desire
    self.okButton.clipsToBounds = YES;
    __unsafe_unretained MatchListView * weakSelf = self;
    self.pLabel.labelVCBlock = ^(KAProgressLabel *label) {
        weakSelf.pLabel.startLabel.text = [NSString stringWithFormat:@"%.f",weakSelf.pLabel.startDegree];
        weakSelf.pLabel.endLabel.text = [NSString stringWithFormat:@"%.f",weakSelf.pLabel.endDegree];

    };
    
    [self.pLabel setTrackWidth: 28];
    [self.pLabel setProgressWidth: 28.2];
    self.pLabel.fillColor = [Color greyBackgroundColor];
    self.pLabel.trackColor = [Color orangeThemeColor];
    self.pLabel.progressColor = [Color greyThemeColor];
    self.pLabel.isStartDegreeUserInteractive = YES;
    self.pLabel.isEndDegreeUserInteractive = YES;
}

-(void)onTick:(NSTimer*)t{
    CGFloat degree = 360.0-(_startTime/30.0)*360.0;
    [self.pLabel setText:[NSString stringWithFormat:@"%d",_startTime]];
    [self.pLabel setEndDegree:degree];
    if(_startTime==0){
        [_timer invalidate];
        return;
    }
    _startTime--;
    
}

-(void)createTimer{
    _startTime=30;
    [self onTick:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector:@selector(onTick:)
                                                userInfo: nil repeats:YES];

}

@end
