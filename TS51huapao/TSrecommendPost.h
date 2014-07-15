//
//  TSrecommendPost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSRcmd.h"

@interface TSrecommendPost : NSObject

@property (strong, nonatomic) TSRcmd * prdctRcmd1;

@property (strong, nonatomic) TSRcmd * prdctRcmd2;

@property (strong, nonatomic) TSRcmd * prdctRcmd3;

@property (strong, nonatomic) TSRcmd * subjctRcmd1;

@property (strong, nonatomic) TSRcmd * subjctRcmd2;

@property (strong, nonatomic) TSRcmd * subjctRcmd3;

@property (strong, nonatomic) NSMutableArray * labelarray;

@property (strong, nonatomic) NSMutableDictionary * getDic;

@property (strong, nonatomic) NSString * telephoneNumeber;

-(instancetype)initWithAttributes:(NSDictionary *)attributes;
+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithBlock:(void(^)(TSrecommendPost *post,NSError *error))block;

@end
