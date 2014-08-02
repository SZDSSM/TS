//
//  TSGetItemListPost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-20.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSGetItemListPost : NSObject

@property (strong, nonatomic) NSString * itemCode;
@property (strong, nonatomic) NSString * ItemName;
@property (strong, nonatomic) NSString * Spec;
@property (strong, nonatomic) NSString * SalesVolume;
@property (strong, nonatomic) NSString * stocksum;
@property (strong, nonatomic) NSString * Price;
@property (strong, nonatomic) NSString * costPrice;
@property (strong, nonatomic) NSString * oldPrice;

@property (strong, nonatomic) NSString * U_Neu_Content;
@property (strong, nonatomic) NSString * IsOTO;
@property (strong, nonatomic) NSString * IsRebate;
@property (strong, nonatomic) NSString * IsStroe;
@property (strong, nonatomic) NSString * U_Photo1;
@property (strong, nonatomic) NSString * UMTVURL;

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block;


@end
