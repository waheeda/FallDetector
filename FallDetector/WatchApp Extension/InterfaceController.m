//
//  InterfaceController.m
//  WatchApp Extension
//
//  Created by Waheeda on 11/5/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import "InterfaceController.h"
#import "HttpRequestManager.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        
    }

    [[HttpRequestManager new] get:@"https://cricscore-api.appspot.com/csa" success:^(id response) {
        NSLog(@"%@", response);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    } entity:nil];
    
    
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{
    
    if(message){
        
        NSDictionary* messageReceived = message;
        NSLog(@"Received Message in watch: %@",messageReceived);
//       // [self.replyLabel setText:command];
//        
//        NSString* otherCounter = [message objectForKey:@"counter"];
//        
//        
//        NSDictionary* response = @{@"response" : [NSString stringWithFormat:@"Message %@ received.",otherCounter]} ;
//        
//        
//        if (replyHandler != nil) replyHandler(response);
//        
        
    }
    
    
}

@end



