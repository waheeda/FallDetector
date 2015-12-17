//
//  MatchListController.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "EmergencyTimerController.h"
#import "MatchResponse.h"
#import "Service.h"
#import "EmergencyTimerView.h"
#import "Alert.h"
#import "LocationManager.h"
#import "UserService.h"
#import "UserDefaults.h"
typedef enum {
    orientationAxisX,
    orientationAxisY,
    orientationAxisZ
} orientationAxis;


@interface EmergencyTimerController ()

@end
orientationAxis refAXIS;

@implementation EmergencyTimerController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTimer];
    // Do any additional setup after loading the view.
    //This is a test
    //This is another test
    [super loadServices:@[@(ServiceTypeContacts),@(ServiceTypeLocation)]];
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    
}


-(void)onTick:(NSTimer*)t{
    CGFloat degree = 360.0-(_startTime/30.0)*360.0;
    [(EmergencyTimerView*)self.view setPLabelText:_startTime];
    [(EmergencyTimerView*)self.view setPlabelEndDegree:degree];
    if(_startTime==0){
        [_timer invalidate];
        [self showLoader];
        [service.location sendEmail:[UserDefaults getEmail] withLocation:[[LocationManager getInstance] location] withSuccess:^(id response) {
            [self hideLoader];
            [[LocationManager getInstance] stop];
            [Alert show:@"Alert" andMessage:@"Your Contacts have been notified"];
            NSLog(@"Latitude:%f and Longitude:%f",[[LocationManager getInstance] location].latitude,[[LocationManager getInstance] location].longitude);
            [self.navigationController popViewControllerAnimated:YES];
        } andfailure:^(NSError *error) {
            [super onServiceResponseFailure:error];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        return;
    }
    _startTime--;
    
}

-(void)createTimer{
    _startTime=5;
    [self onTick:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                              target: self
                                            selector:@selector(onTick:)
                                            userInfo: nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//-(void)createInitialSetup:(CMAccelerometerData *)accelerometerData{
//    double absouluteX = ABS( accelerometerData.acceleration.x);
//    double absouluteY = ABS( accelerometerData.acceleration.y);
//    double absouluteZ = ABS( accelerometerData.acceleration.z);
//    
//    
//        if(absouluteX>absouluteY && absouluteX>absouluteZ){
//            initialAngle = acos(accelerometerData.acceleration.x/_totalAcceleration);
//            if(isnan(initialAngle)){
//                return;
//            }
//            _totalAngles=_totalAngles+initialAngle;
//            NSLog(@"X axis downwards");
//        }
//        else if(absouluteY>absouluteX && absouluteY>absouluteZ){
//            //Y pointing downwards
//            initialAngle = acos(accelerometerData.acceleration.y/_totalAcceleration);
//            if(isnan(initialAngle)){
//                return;
//            }
//            _totalAngles=_totalAngles+initialAngle;
//            NSLog(@"Y axis downwards");
//        }
//        else{
//            initialAngle = acos(accelerometerData.acceleration.z/_totalAcceleration);
//            if(isnan(initialAngle)){
//                return;
//            }
//            _totalAngles=_totalAngles+initialAngle;
//            NSLog(@"Z axis downwards");
//        }
//        
//        _anglesCount++;
//        NSLog(@"Intial Angle: %f",initialAngle);
//        if(_anglesCount==10)
//        {
//            _createSetupOrientation=NO;
//            _avgOrientation = _totalAngles/10;
//            //[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:_avgOrientation]  forKey:@"avgOrientation"];
//            NSLog(@"Avg orientation set");
//            NSLog(@"Avg angle: %f",_avgOrientation);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[(MatchListView*)self.view avgOrientation] setText:[NSString stringWithFormat:@"Avg orientation set with value: %f",_avgOrientation]];
//            });
//        }
//    
//
//}
//
//
//
//-(void)createProgressBar{
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
