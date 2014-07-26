//
//  TSItemDetailPost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSItemDetailPost : NSObject

@property (strong, nonatomic) NSString * CostPrice;

@property (strong, nonatomic) NSString * Effect;

@property (strong, nonatomic) NSString * IsEnsure;

@property (strong, nonatomic) NSString * IsFreeShip;

@property (strong, nonatomic) NSString * IsHot;

@property (strong, nonatomic) NSString * IsNewPrdct;

@property (strong, nonatomic) NSString * IsQaTest;

@property (strong, nonatomic) NSString * IsStroe;

@property (strong, nonatomic) NSString * IsTrade;

@property (strong, nonatomic) NSString * ItemCode;

@property (strong, nonatomic) NSString * ItemName;

@property (strong, nonatomic) NSString * ItmsGrpNam;

@property (strong, nonatomic) NSString * Price;

@property (strong, nonatomic) NSString * SalesVolume;

@property (strong, nonatomic) NSString * Spec;

@property (strong, nonatomic) NSString * UMTVURL;

@property (strong, nonatomic) NSString * U_NEU_PriceNote;

@property (strong, nonatomic) NSNumber * U_NEU_Rebate;


@property (strong, nonatomic) NSString * U_NEU_RoughWeight;

@property (strong, nonatomic) NSString * U_NEU_SaleType;

@property (strong, nonatomic) NSString * U_NEU_boxboard;

@property (strong, nonatomic) NSString * U_NEU_cuxiao;

@property (strong, nonatomic) NSString * U_Neu_Content;

@property (strong, nonatomic) NSString * U_Photo1;

@property (strong, nonatomic) NSString * U_Photo2;

@property (strong, nonatomic) NSString * U_clicksum;

@property (strong, nonatomic) NSString * cardcode;

@property (strong, nonatomic) NSString * cardname;

@property (strong, nonatomic) NSArray * photolist;

@property (strong, nonatomic) NSString * stocksum;

@property (strong, nonatomic) NSString * miaoshu;

@property (strong, nonatomic) NSString * shuoming;

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithItemcode:(NSString *)itemcode Block:(void(^)(TSItemDetailPost *post,NSError *error))block;


@end
