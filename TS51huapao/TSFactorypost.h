//
//  TSFactorypost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-18.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSFactorypost : NSObject

@property (nonatomic, strong) NSString * ItemCode;
@property (nonatomic, strong) NSString * ItemName;
@property (nonatomic, strong) NSString * Spec;
@property (nonatomic, strong) NSString * VendorPrice;
@property (nonatomic, strong) NSString * Price;
@property (nonatomic, strong) NSString * costPrice;
@property (nonatomic, strong) NSString * U_Neu_Content;
@property (nonatomic, strong) NSString * IsOTO;
@property (nonatomic, strong) NSString * IsRebate;
@property (nonatomic, strong) NSString * IsStroe;
@property (nonatomic, strong) NSString * IsShangJia;
@property (nonatomic, strong) NSString * IsDaiShou;
@property (nonatomic, strong) NSString * VendorOnhand;
@property (nonatomic, strong) NSString * onHand;
@property (nonatomic, strong) NSString * U_Photo1;
@property (nonatomic, strong) NSString * UMTVURL;

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block;

@end
