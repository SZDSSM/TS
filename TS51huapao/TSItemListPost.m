//
//  TSItemListPost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-16.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSItemListPost.h"
#import "TSAppDoNetAPIClient.h"


@implementation TSItemListPost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    self.itemCode = [self changeString:[attributes valueForKey:@"ItemCode"]];
    self.ItemName = [self changeString:[attributes valueForKey:@"ItemName"]];
    self.Spec = [self changeString:[attributes valueForKey:@"Spec"]];
    self.SalesVolume = [self changeString:[attributes valueForKey:@"SalesVolume"]];
    self.stocksum = [self changeString:[attributes valueForKey:@"stocksum"]];
    self.Price = [self changeString:[attributes valueForKey:@"Price"]];
    self.costPrice = [self changeString:[attributes valueForKey:@"costPrice"]];
    self.U_Neu_Content = [self changeString:[attributes valueForKey:@"U_Neu_Content"]];
    self.IsOTO = [self changeString:[attributes valueForKey:@"IsOTO"]];
    self.IsRebate = [self changeString:[attributes valueForKey:@"IsRebate"]];
    self.IsStroe = [self changeString:[attributes valueForKey:@"IsStroe"]];
    self.U_Photo1 = [self changeString:[attributes valueForKey:@"U_Photo1"]];
    self.UMTVURL = [self changeString:[attributes valueForKey:@"UMTVURL"]];
    
    self.StorDateTime = [self changeString:[attributes objectForKey:@"StorDateTime"]];//新加
    self.Vipcode = [self changeString:[attributes objectForKey:@"Vipcode"]];//新加
    self.vipname = [self changeString:[attributes objectForKey:@"vipname"]];//新加
    self.viptype = [self changeString:[attributes objectForKey:@"viptype"]];//新加
    self.quantity = [self changeString:[attributes objectForKey:@"quantity"]];//新加
    self.note = [self changeString:[attributes objectForKey:@"note"]];//新加
    self.status = [self changeString:[attributes objectForKey:@"status"]];//新加
    self.lineid = [self changeString:[attributes objectForKey:@"lineid"]];//新加
    self.cardname = [self changeString:[attributes objectForKey:@"cardname"]];//新加
    return self;
}
- (NSString *)changeString:(id)sender
{
    if ([sender isEqual:[NSNull null]]) {
        return @"";
    }
    NSString * str = [NSString string];
    str = [NSString stringWithFormat:@"%@",sender];
    if ([str isKindOfClass:[NSNull class]]){
        str = @"";
    }
    return str;
}
//- (NSString *)changeString:(NSString *)sender
//{
//    NSString * str = [NSString string];
//    str = [NSString stringWithFormat:@"%@",sender];
//    if ([str isKindOfClass:[NSNull class]]){
//        str = @" ";
//    }
//    return str;
//}

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithRanktype:(NSString *)rankType Block:(void(^)(NSArray * posts,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetRankingList.ashx" parameters:@{@"rankType":rankType,@"vipcode":[TSUser sharedUser].vipcode} success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSLog(@"ppppp:%@",responseObject);
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSItemSP"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
                    TSItemListPost *post=[[TSItemListPost alloc] initWithAttributes:(NSDictionary *)attributes];
            [mutablePosts addObject:post];
        }
        if(block){
            block([NSArray arrayWithArray:mutablePosts],nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block([NSArray array],error);
        }
    }];
}

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetItemListSP.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"ppppp:%@",responseObject);
        //        id i=[responseObject valueForKeyPath:@"maxcount"];
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSItemSP"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSItemListPost *post=[[TSItemListPost alloc] initWithAttributes:(NSDictionary *)attributes];
            [mutablePosts addObject:post];
        }
        if(block){
            block([NSArray arrayWithArray:mutablePosts],max.integerValue,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block([NSArray array],0,error);
        }
    }];
}


+(NSURLSessionDataTask *)globalTimeGetMyStorUpInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetMyStorUpItemList.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSMyStorUpItemSP"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSItemListPost *post=[[TSItemListPost alloc] initWithAttributes:(NSDictionary *)attributes];
            [mutablePosts addObject:post];
        }
        if(block){
            block([NSArray arrayWithArray:mutablePosts],max.integerValue,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block([NSArray array],0,error);
        }
    }];
}

+(NSURLSessionDataTask *)globalTimeGetKanyangInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetSampleItem.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSMyStorUpItemSP"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSItemListPost *post=[[TSItemListPost alloc] initWithAttributes:(NSDictionary *)attributes];
            [mutablePosts addObject:post];
        }
        if(block){
            block([NSArray arrayWithArray:mutablePosts],max.integerValue,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block([NSArray array],0,error);
        }
    }];
}

+(NSURLSessionDataTask *)globalTimeGetYiXiangDingdanInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetOrderItemList.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSMyStorUpItemSP"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSItemListPost *post=[[TSItemListPost alloc] initWithAttributes:(NSDictionary *)attributes];
            [mutablePosts addObject:post];
        }
        if(block){
            block([NSArray arrayWithArray:mutablePosts],max.integerValue,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block([NSArray array],0,error);
        }
    }];
}


@end
