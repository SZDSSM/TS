//
//  TSCoLtdpost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-17.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSCoLtdpost.h"
#import "TSAppDoNetAPIClient.h"


@implementation TSCoLtdpost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    self.CardCode = [self changeString:[attributes objectForKey:@"CardCode"]];
    self.CardName = [self changeString:[attributes objectForKey:@"CardName"]];
    self.CardType = [self changeString:[attributes objectForKey:@"CardType"]];
    self.Cellolar = [self changeString:[attributes objectForKey:@"Cellolar"]];
    self.CntctPrsn = [self changeString:[attributes objectForKey:@"CntctPrsn"]];
    self.Phone1 = [self changeString:[attributes objectForKey:@"Phone1"]];
    self.U_unittype = [self changeString:[attributes objectForKey:@"U_unittype"]];
    self.Address = [self changeString:[attributes objectForKey:@"Address"]];
    self.ClientArea = [self changeString:[attributes objectForKey:@"ClientArea"]];
    self.UMainPro = [self changeString:[attributes objectForKey:@"UMainPro"]];
    self.U_uaddress = [self changeString:[attributes objectForKey:@"U_uaddress"]];
    
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

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"GetCardList.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"ppppp:%@",responseObject);
        id i=[responseObject valueForKeyPath:@"maxcount"];
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSCard"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSCoLtdpost *post=[[TSCoLtdpost alloc] initWithAttributes:(NSDictionary *)attributes];
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
