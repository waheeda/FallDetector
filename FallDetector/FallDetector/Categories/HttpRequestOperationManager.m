//
//  HttpRequestOperationManager.m
//  iOSTemplate
//
//  Created by Waheeda on 6/26/15.
//  Copyright (c) 2015 10Pearls. All rights reserved..
//

#import "HttpRequestOperationManager.h"


@implementation HttpRequestOperationManager


- (NSURLSessionDataTask *)makeHttpRequestWithMethod:(HttpMethod)method
                                                     URLString:(NSString *)URLString
                                                    parameters:(id)parameters
                                                       success:(void (^)(URLSessionDataTask *operation, id responseObject))success
                                                       failure:(void (^)(URLSessionDataTask *operation, NSError *error))failure {

    NSURLSessionDataTask *operation;

    switch (method) {
        case HttpMethodGET:
            operation = [self GET_CUSTOM:URLString parameters:parameters success:success failure:failure];
            break;
        case HttpMethodPOST:
            operation = [self POST_CUSTOM:URLString parameters:parameters success:success failure:failure];
            break;
        case HttpMethodPUT:
            operation = [self PUT_CUSTOM:URLString parameters:parameters success:success failure:failure];
            break;
        case HttpMethodDELETE:
            operation = [self DELETE_CUSTOM:URLString parameters:parameters success:success failure:failure];
            break;
        default:
            break;
    }
    return operation;
}


-(NSURLSessionDataTask *) GET_CUSTOM:(NSString *)URLString parameters:(id)parameters success:(void (^)(URLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(URLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    return [super GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self onSuccess:task responseObject:responseObject success:success];

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self onFailure:task error:error failure:failure];
    }];

}

-(NSURLSessionDataTask *) POST_CUSTOM:(NSString *)URLString parameters:(id)parameters success:(void (^)(URLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(URLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    return [super POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self onSuccess:task responseObject:responseObject success:success];

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self onFailure:task error:error failure:failure];
    }];
    
}

-(NSURLSessionDataTask *) PUT_CUSTOM:(NSString *)URLString parameters:(id)parameters success:(void (^)(URLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(URLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    return [super PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self onSuccess:task responseObject:responseObject success:success];

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self onFailure:task error:error failure:failure];
    }];
    
}

-(NSURLSessionDataTask *) DELETE_CUSTOM:(NSString *)URLString parameters:(id)parameters success:(void (^)(URLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(URLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    return [super DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self onSuccess:task responseObject:responseObject success:success];

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self onFailure:task error:error failure:failure];
    }];
    
}

-(void) onSuccess:(NSURLSessionDataTask *) task responseObject:(id) responseObject success:(void (^)(URLSessionDataTask *operation, id responseObject))success{

    URLSessionDataTask *operation = [self updateSessionDataTask:task];
    success(operation, responseObject);
}

-(void) onFailure:(NSURLSessionDataTask *) task error:(NSError *) error failure:(void (^)(URLSessionDataTask *operation, NSError * error))failure{

    URLSessionDataTask *operation = [self updateSessionDataTask:task];
    failure(operation, error);
}

-(URLSessionDataTask *) updateSessionDataTask:(NSURLSessionDataTask *) operation {


    URLSessionDataTask *task = [URLSessionDataTask new];
    task.taskDescription = operation.taskDescription;
    task.taskIdentifier = operation.taskIdentifier;
    task.currentRequest = operation.currentRequest;
    task.originalRequest = operation.originalRequest;
    task.response = operation.response;
    return task;
}


-(void) setHttpHeaders:(NSDictionary *)headers  {

  for (NSString *key in headers) {
      if([headers objectForKey:key])
        [self.requestSerializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
}

-(void) clearAuthorizationHeader {
    [self.requestSerializer clearAuthorizationHeader];
}

@end
