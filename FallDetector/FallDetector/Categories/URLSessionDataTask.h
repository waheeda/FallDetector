//
//  URLSessionDataTask.h
//  CricketInfo
//
//  Created by Waheeda on 11/6/15.
//  Copyright © 2015 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLSessionDataTask : NSURLSessionDataTask

#if NS_BLOCKS_AVAILABLE
typedef void (^successCallback)(id response);
typedef void (^failureCallback)(NSError *error);
#endif

@property (copy) successCallback onSuccessCallback;
@property (copy) failureCallback onFailureCallback;


@property (readwrite)       NSUInteger    taskIdentifier;    /* an identifier for this task, assigned by and unique to the owning session */
@property (readwrite, copy) NSURLRequest  *originalRequest;  /* may be nil if this is a stream task */
@property (readwrite, copy) NSURLRequest  *currentRequest;   /* may differ from originalRequest due to http server redirection */
@property (readwrite, copy) NSURLResponse *response;         /* may be nil if no response has been received */
@property (readwrite, copy) NSString      *taskDescription;


@end
