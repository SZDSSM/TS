//
//  TSdingdanpost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSdingdanpost : NSObject

@property (nonatomic, strong) NSString * DocDate;
@property (nonatomic, strong) NSString * DocEntry;
@property (nonatomic, strong) NSString * CardCode;
@property (nonatomic, strong) NSString * CardName;
@property (nonatomic, strong) NSString * Quantity;
@property (nonatomic, strong) NSString * OpenQty;
@property (nonatomic, strong) NSString * DocTotal;
@property (nonatomic, strong) NSString * DocStatus;
@property (nonatomic, strong) NSString * U_NEU_DocTpe;
@property (nonatomic, strong) NSString * U_NEU_drvr;
@property (nonatomic, strong) NSString * U_NEU_MbTel;
@property (nonatomic, strong) NSString * U_NEU_Urgency;
@property (nonatomic, strong) NSString * U_RebateSUM;
@property (nonatomic, strong) NSString * Rebate;
@property (nonatomic, strong) NSString * ItemCode;
@property (nonatomic, strong) NSString * ItemName;
@property (nonatomic, strong) NSString * Spec;
@property (nonatomic, strong) NSString * U_Neu_Content;
@property (nonatomic, strong) NSString * Price;
@property (nonatomic, strong) NSString * LineTotal;
@property (nonatomic, strong) NSString * U_Photo1;

+(NSURLSessionDataTask *)globalTimeGetAnVipTradeConditionWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block;

@end
