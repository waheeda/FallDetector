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

@interface MatchListController ()

@end

@implementation MatchListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super loadServices:@[@(ServiceTypeMatch) , @(ServiceTypeUser)]];
    [self getMatchList];
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getMatchList{
    [service.matchService getMatches:^(id response) {
//        NSArray *list = [(MatchResponse*)response getList];
//        NSDictionary* messageToSend = list.firstObject;
        [self sendMessageToWatch:response];
    } andfailure:^(NSError *error) {
        
    }];
}

-(void)sendMessageToWatch:(NSDictionary*)messageToSend{
    // NSDictionary* messageToSend = @{@"request":[NSString stringWithFormat:@"Message %d from the Phone",self.counter] ,@"counter":[NSString stringWithFormat:@"%d",self.counter]};
    
    if(WCSession.isSupported){
        
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        
        /*
         Discussion
         In your WatchKit extension, the value of this property is YES when a matching session is active on the user’s iPhone and the device is within range so that communication may occur. On iOS, the value is YES when the paired Apple Watch is in range and the associated Watch app is running in the foreground. In all other cases, the value is NO.
         
         The counterpart must be reachable in order for you to send messages using the sendMessage:replyHandler:errorHandler: and sendMessageData:replyHandler:errorHandler: methods. Sending messages to a counterpart that is not reachable results in an error.
         
         The session must be configured and activated before accessing this property.
         */
        if(session.reachable)
        {
            
            
            
            /*
             Discussion
             Use this message to send a dictionary of data to the counterpart as soon as possible. Messages are queued serially and delivered in the order in which you sent them. Delivery of the messages happens asynchronously, so this method returns immediately.
             
             If you specify a reply handler block, your handler block is executed asynchronously on a background thread. The block is executed serially with respect to other incoming delegate messages.
             
             Calling this method from your WatchKit extension while it is active and running wakes up the corresponding iOS app in the background and makes it reachable. Calling this method from your iOS app does not wake up the corresponding WatchKit extension. If you call this method and the counterpart is unreachable (or becomes unreachable before the message is delivered), the errorHandler block is executed with an appropriate error. The errorHandler block may also be called if the message parameter contains non property list data types.
             */
            
            
            [session sendMessage:messageToSend replyHandler: ^(NSDictionary<NSString *,id> * __nonnull replyMessage)
             {
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSLog(@".....replyHandler called --- %@",replyMessage);
                     
                     NSDictionary* message = replyMessage;
                     
                     NSString* response = message[@"response"];
                     
//                     if(response)
//                         [self.replyLabel setText:response];
//                     else
//                         [self.replyLabel setText:@"nil"];
//                     
                     
                     
                     
                 });
                 
                 
                 
                 
             }
             
                    errorHandler:^(NSError * __nonnull error) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"%@",error.localizedDescription);
                            //[self.replyLabel setText:error.localizedDescription];
                        });
                        
                    }
             
             
             ];
        }
        else
        {
            NSLog( @"Session Not reachable");
        }
        
    }
    else
    {
         NSLog( @"Session Not supported");
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
