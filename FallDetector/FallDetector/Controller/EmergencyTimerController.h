//
//  MatchListController.h
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import <CoreMotion/CoreMotion.h>
@interface EmergencyTimerController : BaseController <WCSessionDelegate>{
        NSTimer *_timer;
        int _startTime;
}
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (atomic, strong) NSMutableArray *array;

@end
