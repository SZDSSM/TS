//
//  TSrecommendPost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSrecommendPost.h"
#import "TSAppDoNetAPIClient.h"

@implementation TSrecommendPost


-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    self.labelarray=[attributes valueForKeyPath:@"TnavigationLabels"];
    return self;
}

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithBlock:(void(^)(TSrecommendPost *post,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetAnItemData.ashx" parameters:@{@"itemcode":@"91781117"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"ppppp:%@",responseObject);
        TSrecommendPost *post=[[TSrecommendPost alloc] initWithAttributes:(NSDictionary *)responseObject];
        if(block){
            block(post,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];
}
@end
