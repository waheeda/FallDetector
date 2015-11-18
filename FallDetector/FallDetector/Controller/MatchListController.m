//
//  MatchListController.m
//  CricketInfo
//
//  Created by Muhammad Hamiz Ahmed on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "MatchListController.h"
#import "MatchResponse.h"
#import "Service.h"
#import "MatchListView.h"
typedef enum {
    orientationAxisX,
    orientationAxisY,
    orientationAxisZ
} orientationAxis;
@interface MatchListController ()

@end
orientationAxis refAXIS;

@implementation MatchListController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //This is a test
    //This is another test
    
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        
    }
    
     [[(MatchListView*)self.view avgOrientation] setText:[NSString stringWithFormat:@"dummy text"]];
    _createSetupOrientation = YES;
    _totalAngles=0;
    _count=0;
    _array=[[NSMutableArray alloc] init];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval =0.01;  //0.015
    
    if ([self.motionManager isAccelerometerAvailable])// & [self.motionManager isAccelerometerActive])
    {
        NSLog(@"Accelerometer is active and available");
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         
         {
             [queue setMaxConcurrentOperationCount:1];
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 _totalAcceleration =sqrt((accelerometerData.acceleration.x*accelerometerData.acceleration.x)+
                                          (accelerometerData.acceleration.y*accelerometerData.acceleration.y)+
                                          (accelerometerData.acceleration.z*accelerometerData.acceleration.z));
                
             });
             
              [_array addObject:[NSNumber numberWithDouble:_totalAcceleration]];
             
             if(_count==100){
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [[(MatchListView*)self.view fallDetectionLabel] setText:@"dssdfdsfdsf"];
                 });
                 
                 if(_createSetupOrientation){
                     [self createInitialSetup:accelerometerData];
                 }
                 
                 double max = [[_array valueForKeyPath:@"@max.doubleValue"] doubleValue];
                 double min =[[_array valueForKeyPath:@"@min.doubleValue"] doubleValue];
                 int maxIndex=[_array indexOfObject:[NSNumber numberWithDouble:max]];
                 int minIndex = [_array indexOfObject:[NSNumber numberWithDouble:min]];
                 _count=0;
                 if((max-min)>=2.5 && maxIndex>minIndex){
                     NSLog(@"Max:%f, Min:%f",max,min); //fall occured by acceleration
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
                                 [[(MatchListView*)self.view fallDetectionLabel] setText:[NSString stringWithFormat:@"Fall occured in x with angle:%f",mesauredAngle] ];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                [[(MatchListView*)self.view avgOrientation] setText:[NSString stringWithFormat:@"Avg orientation set with value: %f",_avgOrientation]];
            });
        }
    

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
