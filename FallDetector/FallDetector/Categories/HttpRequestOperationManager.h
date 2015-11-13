//
//  HttpRequestOperationManager.h
//  iOSTemplate
//
//  Created by Waheeda on 6/26/15.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import "AFHTTPSessionManager.h"
#import "Enum.h"
#import "URLSessionDataTask.h"

@interface HttpRequestOperationManager : AFHTTPSessionManager


- (NSURLSessionDataTask *)makeHttpRequestWithMethod:(HttpMethod)method
                                          URLString:(NSString *)URLString
                                         parameters:(id)parameters
                                            success:(void (^)(URLSessionDataTask *operation, id responseObject))success
                                            failure:(void (^)(URLSessionDataTask *operation, NSError *error))failure ;


-(void) setHttpHeaders:(NSDictionary *)headers;
-(void) clearAuthorizationHeader;
@end
