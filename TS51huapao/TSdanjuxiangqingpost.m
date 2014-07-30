//
//  TSdanjuxiangqingpost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSdanjuxiangqingpost.h"
#import "TSAppDoNetAPIClient.h"

@implementation TSdanjuxiangqingpost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    
    self.ItemCode = [self changeString:[attributes objectForKey:@"ItemCode"]];
    self.ItemName = [self changeString:[attributes objectForKey:@"ItemName"]];
    self.Spec = [self changeString:[attributes objectForKey:@"Spec"]];
    self.U_Neu_Content = [self changeString:[attributes objectForKey:@"U_Neu_Content"]];
    self.Quantity = [self changeString:[attributes objectForKey:@"Quantity"]];
    self.OpenQty = [self changeString:[attributes objectForKey:@"OpenQty"]];
    self.Price = [self changeString:[attributes objectForKey:@"Price"]];
    self.Total = [self changeString:[attributes objectForKey:@"Total"]];
    self.U_Photo1 = [self changeString:[attributes objectForKey:@"U_Photo1"]];
    
    return self;
}

- (NSString * )changeString:(id)sender
{
    if ([sender isEqual:[NSNull null]]) {
        return @"";
    }
    NSString * str = [NSString string];
    str = [NSString stringWithFormat:@"%@",sender];
    if ([str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
    return str;
}

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetAnDoctradeList.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSDocItem"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSdanjuxiangqingpost *post=[[TSdanjuxiangqingpost alloc] initWithAttributes:(NSDictionary *)attributes];
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


@end
