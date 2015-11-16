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
@interface MatchListController : BaseController <WCSessionDelegate>{
    //NSMutableArray *_array;
    int _count;
    BOOL _fallDetected;
    int _fallCount;
    BOOL _createSetupOrientation;
    double initialAngle;
    double _totalAcceleration;
    double _totalAngles;
    int _anglesCount;
    double _avgOrientation;
    int _positionNotUprightCount;
    int seconds;
}
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (atomic, strong) NSMutableArray *array;

@end
