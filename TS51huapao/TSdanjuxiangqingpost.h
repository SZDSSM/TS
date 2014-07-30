//
//  TSdanjuxiangqingpost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSdanjuxiangqingpost : NSObject

@property (nonatomic, strong) NSString * ItemCode;
@property (nonatomic, strong) NSString * ItemName;
@property (nonatomic, strong) NSString * Spec;
@property (nonatomic, strong) NSString * U_Neu_Content;
@property (nonatomic, strong) NSString * OpenQty;
@property (nonatomic, strong) NSString * Quantity;
@property (nonatomic, strong) NSString * Price;
@property (nonatomic, strong) NSString * Total;
@property (nonatomic, strong) NSString * U_Photo1;


+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSError *error))block;

@end
