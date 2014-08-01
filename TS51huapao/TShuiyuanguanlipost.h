//
//  TShuiyuanguanlipost.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TShuiyuanguanlipost : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * cardName;
@property (nonatomic, strong) NSString * U_type;
@property (nonatomic, strong) NSString * U_name;
@property (nonatomic, strong) NSString * JoinDateTime;
@property (nonatomic, strong) NSString * status;

+(NSURLSessionDataTask *)globalTimeGetVipListWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSError *error))block;

@end
