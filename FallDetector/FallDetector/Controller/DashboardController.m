//
//  MonitoringController.m
//  FallDetector
//
//  Created by Muhammad Hamiz Ahmed on 11/23/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "DashboardController.h"
#import "EmergencyTimerController.h"
#import "DashboardView.h"
#import "FacebookManager.h"
#import "LocationManager.h"
#import "Alert.h"
#import "StringUtils.h"
#import "UserDefaults.h"
@interface DashboardController ()

@end

@implementation DashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setupImageNavBAr];
    [self setupImageNavBAr];
    [super showContactsNotFoundAlert];
    [(DashboardView*)self.view setUsernameLabelText:[StringUtils getUserNameFromEmail:[UserDefaults getEmail]]];
    self.navigationItem.leftBarButtonItem = [super createLeftMenuButton];
    
}

//-(void)fetchFBData{
//    //service call
//    [FacebookManager fetchUserInfo:^(id result, NSError *error) {
//      NSLog(@"%@",[result valueForKey:@"name"]);
//    }];
//}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:false];
    _createSetupOrientation = YES;
    _anglesCount=0;
}

-(void)setupImageNavBAr{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:101/255.0f green:101/255.0f blue:101/255.0f alpha:1.0f]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = YES;
    UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fallCeption.png"]];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    [self.navigationItem setTitleView:imgView];
}


-(void)resetVariables{
    _totalAngles=0;
    _count=0;
}

-(void)calculateAcceleration:(CMAccelerometerData *)accelerometerData{
    _totalAcceleration =sqrt((accelerometerData.acceleration.x*accelerometerData.acceleration.x)+
                             (accelerometerData.acceleration.y*accelerometerData.acceleration.y)+
                             (accelerometerData.acceleration.z*accelerometerData.acceleration.z));
}

-(void)startMonitoring{
    
    [self resetVariables];
    _array=[[NSMutableArray alloc] init];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval =0.01;  //0.015
    
    if ([self.motionManager isAccelerometerAvailable])// & [self.motionManager isAccelerometerActive])
    {
        NSLog(@"Accelerometer is active and available");
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         
         {
             //NSLog(@"Accelraor updating");
             [queue setMaxConcurrentOperationCount:1];
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 [self calculateAcceleration:accelerometerData];
                 
             });
             
             [_array addObject:[NSNumber numberWithDouble:_totalAcceleration]];
             
             if(_count==100){
                 _count=0;
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //[[(MatchListView*)self.view fallDetectionLabel] setText:@"dssdfdsfdsf"];
                 });
                 
                 if(_createSetupOrientation){
                     [self createInitialSetup:accelerometerData];
                 }
                 
                 double max = [[_array valueForKeyPath:@"@max.doubleValue"] doubleValue];
                 double min =[[_array valueForKeyPath:@"@min.doubleValue"] doubleValue];
                 int maxIndex=[_array indexOfObject:[NSNumber numberWithDouble:max]];
                 int minIndex = [_array indexOfObject:[NSNumber numberWithDouble:min]];
                 
                 if((max-min)>=2 && maxIndex>minIndex){ //(max-min)>=7
                     NSLog(@"Max:%f, Min:%f",max,min);
                    // [[(MatchListView*)self.view avgOrientation] setText:[NSString stringWithFormat:@"Max-Min:%f",max-min]];
                     //fall occured by acceleration
                     NSLog(@"Threshold exceeded");
                     _fallDetected=true;
                 }
                 //Z pointing downwards
                 
                 
                 
                 
                 
                 //_array=[NSMutableArray new];
                 if(_fallDetected){
                     //check downwards pointing angle
                     /* double absouluteX = ABS( accelerometerData.acceleration.x);
                      double absouluteY = ABS( accelerometerData.acceleration.y);
                      double absouluteZ = ABS( accelerometerData.acceleration.z);*/
                     //if(absouluteX>absouluteY && absouluteX>absouluteZ){
                     double mesauredAngle = acos(accelerometerData.acceleration.y/_totalAcceleration);
                     double normalizedAngle = mesauredAngle - initialAngle;
                     NSLog(@"Measured Angle: %f",mesauredAngle);
                     if(!(normalizedAngle>-0.5235987756 && normalizedAngle<0.5235987756)){
                         //orientation not upright
                         _positionNotUprightCount++;
                         // NSLog(@"Fall occured in x");
                         
                         /* dispatch_async(dispatch_get_main_queue(), ^{
                          [[(MatchListView*)self.view fallDetectionLabel] setText:[NSString stringWithFormat:@"Fall occured in x with angle:%f",mesauredAngle] ];
                          });
                          _fallDetected=false;*/
                     }
                     seconds++;
                     
                     if(seconds==5){
                         if(_positionNotUprightCount>2)
                             dispatch_async(dispatch_get_main_queue(), ^{
                                // [[(MatchListView*)self.view fallDetectionLabel] setText:[NSString stringWithFormat:@"Fall occured in x with angle:%f",mesauredAngle] ]; //fall occured final
                                 [self openEmergencyTimerController];
                                 [self.motionManager stopAccelerometerUpdates];
                                 
                             });
                         _fallDetected=false;
                         seconds=0;
                         _positionNotUprightCount=0;
                         
                     }
                     
                     
                     //}
                     
                     /* else if(absouluteY>absouluteX && absouluteY>absouluteZ){
                      //Y pointing downwards
                      double mesauredAngle = acos(accelerometerData.acceleration.y/_totalAcceleration);
                      double normalizedAngle = mesauredAngle - initialAngle;
                      NSLog(@"Measured Angle: %f",mesauredAngle);
                      if(!(normalizedAngle>-0.5235987756 && normalizedAngle<0.5235987756)){
                      //orientation not upright
                      NSLog(@"Fall occured in y");
                      dispatch_async(dispatch_get_main_queue(), ^{
                      [[(MatchListView*)self.view fallDetectionLabel] setText:@"Fall occured in y"];
                      });
                      _fallDetected=false;
                      
                      }
                      }
                      else{
                      double mesauredAngle = acos(accelerometerData.acceleration.z/_totalAcceleration);
                      double normalizedAngle = mesauredAngle - initialAngle;
                      NSLog(@"Measured Angle: %f",mesauredAngle);
                      if(!(normalizedAngle>-0.5235987756 && normalizedAngle<0.5235987756)){
                      //orientation not upright
                      NSLog(@"Fall occured in z");
                      dispatch_async(dispatch_get_main_queue(), ^{
                      [[(MatchListView*)self.view fallDetectionLabel] setText:@"Fall occured in z"];
                      });
                      _fallDetected=false;
                      }
                      
                      }*/
                     //Z pointing downwards
                     
                 }
                 
                 [_array removeAllObjects];
                 
                 
                 return;
             }
             
             _count++;
             
             //             NSLog(@"Total Acceleration is:%f\nX = %f, Y = %f, Z = %f",
             //                   totalAcceleration,
             //                   accelerometerData.acceleration.x,
             //                   accelerometerData.acceleration.y,
             //                   accelerometerData.acceleration.z);
             //
             /*dispatch_async(dispatch_get_main_queue(), ^{
              self.xAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.x];
              self.yAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.y];
              self.zAxis.text = [NSString stringWithFormat:@"%.2f",accelerometerData.acceleration.z];
              });*/
         }];
    }
    else
        NSLog(@"not active");

}


-(void)createInitialSetup:(CMAccelerometerData *)accelerometerData{
    double absouluteX = ABS( accelerometerData.acceleration.x);
    double absouluteY = ABS( accelerometerData.acceleration.y);
    double absouluteZ = ABS( accelerometerData.acceleration.z);
    
    
    if(absouluteX>absouluteY && absouluteX>absouluteZ){
        initialAngle = acos(accelerometerData.acceleration.x/_totalAcceleration);
        if(isnan(initialAngle)){
            return;
        }
        _totalAngles=_totalAngles+initialAngle;
        NSLog(@"X axis downwards");
    }
    else if(absouluteY>absouluteX && absouluteY>absouluteZ){
        //Y pointing downwards
        initialAngle = acos(accelerometerData.acceleration.y/_totalAcceleration);
        if(isnan(initialAngle)){
            return;
        }
        _totalAngles=_totalAngles+initialAngle;
        NSLog(@"Y axis downwards");
    }
    else{
        initialAngle = acos(accelerometerData.acceleration.z/_totalAcceleration);
        if(isnan(initialAngle)){
            return;
        }
        _totalAngles=_totalAngles+initialAngle;
        NSLog(@"Z axis downwards");
    }
    
    _anglesCount++;
    NSLog(@"Intial Angle: %f",initialAngle);
    if(_anglesCount==10)
    {
        _createSetupOrientation=NO;
        _avgOrientation = _totalAngles/10;
        //[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:_avgOrientation]  forKey:@"avgOrientation"];
        NSLog(@"Avg orientation set");
        NSLog(@"Avg angle: %f",_avgOrientation);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[(DashboardView*)self.view nameLabel] setText:[NSString stringWithFormat:@"Avg orientation set with value: %f",_avgOrientation]];
        });
    }
    
    
}

-(void)openEmergencyTimerController{
    EmergencyTimerController *controller = [[EmergencyTimerController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startFetchingLocation {
    [[LocationManager getInstance] getCurrentLocation:^(id location) {
        [self startMonitoring];
    } andFailure:^(NSError *error) {
        switch([error code])
        {
            case kCLErrorNetwork: // general, network-related error
            {
                [Alert show:@"Error" andMessage:@"We are unable to get your location, please check your network connection or that you are not in airplane mode."];
            }
                break;
            case kCLErrorDenied: {
                [Alert show:@"Location Service Disabled" andMessage:@"To re-enable, please go to Settings and turn on Location Service for this app."];
            }
                break;
            default:
            {
                [Alert show:@"Error" andMessage:@"We are unable to get your location."];
            }
                break;
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
