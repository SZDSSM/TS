//
//  TSAppDoNetAPIClient.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface TSAppDoNetAPIClient : AFHTTPSessionManager

+ (instancetype) sharedClient;
@end
