//
//  MonitoringController.h
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/23/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "BaseController.h"
#import <CoreMotion/CoreMotion.h>
@interface DashboardController : BaseController{
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
-(void)startFetchingLocation;
-(void)startMonitoring;
//-(void)fetchFBData;
@end
