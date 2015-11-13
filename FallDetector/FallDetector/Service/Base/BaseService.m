//
// Created by mohsin on 8/14/13.
//


#import "BaseService.h"
#import "Constant.h"

@implementation BaseService



- (id)init {
    if (self = [super init]) {
        http = [HttpRequestManager new];
        http.accessToken = ACCESS_TOKEN;
        [http setHttpHeader:@{@"Content-Type": @"application/json"}];
        core = [CoreDataManager new];
    }
    return self;
}


@end