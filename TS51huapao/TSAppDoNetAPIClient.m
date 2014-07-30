//
//  TSAppDoNetAPIClient.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSAppDoNetAPIClient.h"


static NSString * const AFAppDotNetAPIBaseURLString = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/";

@implementation TSAppDoNetAPIClient

+ (instancetype)sharedClient {
    static TSAppDoNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TSAppDoNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
    });
    
    return _sharedClient;
}
@end
