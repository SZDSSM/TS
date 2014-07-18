//
//  TSCoLtdpost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-17.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCoLtdpost : NSObject

@property (strong, nonatomic) NSString * CardCode;
@property (strong, nonatomic) NSString * CardName;
@property (strong, nonatomic) NSString * CardType;
@property (strong, nonatomic) NSString * Cellolar;
@property (strong, nonatomic) NSString * CntctPrsn;
@property (strong, nonatomic) NSString * Phone1;
@property (strong, nonatomic) NSString * U_unittype;
@property (strong, nonatomic) NSString * Address;
@property (strong, nonatomic) NSString * ClientArea;
@property (strong, nonatomic) NSString * UMainPro;
@property (strong, nonatomic) NSString * U_uaddress;



+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block;



@end
