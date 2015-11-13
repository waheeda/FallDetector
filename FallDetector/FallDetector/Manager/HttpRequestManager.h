//
//  HttpRequestManager.h
//  10Pearls
//
//  Created by mohsin on 4/4/14.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import <Foundation/Foundation.h>
#import "HttpRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "Constant.h"

@class BaseEntity;
@class BaseResponse;

@class ASIHTTPRequest;
#define HTTP_TIMEOUT 40
#define REQUEST_TIMEOUT 60

@interface HttpRequestManager : NSObject{
}

typedef void (^successCallback)(id response);
typedef void (^failureCallback)(NSError *error);

@property(nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic,retain) NSString *accessToken;
@property (nonatomic, strong) HttpRequestOperationManager *manager;

- (void)put:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity;
- (void)put:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject;
- (void)post:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity;
- (void)post:(NSString *)path parameters:(id)parameters success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject;
- (void)get:(NSString *)string success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity;
- (void)get:(NSString *)string success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject;
- (void)delete:(NSString *)string success:(successCallback)success failure:(failureCallback)failure entity:(BaseEntity*)entity;
- (void)delete:(NSString *)string success:(successCallback)success failure:(failureCallback)failure response:(BaseResponse*)responseObject;
-(NSURLSessionDataTask *) makeRequestWithPath:(NSString *)path httpMethod:(HttpMethod)method parameters:(NSDictionary *)parameters success:(successCallback)success failure:(failureCallback)failure ;
-(void) makeRequestWithURL:(NSString *)url httpMethod:(HttpMethod)method parameters:(NSDictionary *)parameters success:(successCallback)success failure:(failureCallback)failure;
-(void) cancelAllOperations;
-(void) setHttpHeader:(NSDictionary *) headers;
@end
