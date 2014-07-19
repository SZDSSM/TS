//
//  TSFactorypost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-18.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSFactorypost.h"
#import "TSAppDoNetAPIClient.h"



@implementation TSFactorypost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    self.ItemCode = [self changeString:[attributes objectForKey:@"ItemCode"]];
    self.ItemName = [self changeString:[attributes objectForKey:@"ItemName"]];
    self.Spec = [self changeString:[attributes objectForKey:@"Spec"]];
    self.VendorPrice = [self changeString:[attributes objectForKey:@"VendorPrice"]];
    self.Price = [self changeString:[attributes objectForKey:@"Price"]];
    self.costPrice = [self changeString:[attributes objectForKey:@"costPrice"]];
    self.U_Neu_Content = [self changeString:[attributes objectForKey:@"U_Neu_Content"]];
    self.IsOTO = [self changeString:[attributes objectForKey:@"IsOTO"]];
    self.IsRebate = [self changeString:[attributes objectForKey:@"IsRebate"]];
    self.IsStroe = [self changeString:[attributes objectForKey:@"IsStroe"]];
    self.IsShangJia = [self changeString:[attributes objectForKey:@"IsShangJia"]];
    self.IsDaiShou = [self changeString:[attributes objectForKey:@"IsDaiShou"]];
    self.onHand = [self changeString:[attributes objectForKey:@"onHand"]];
    self.U_Photo1 = [self changeString:[attributes objectForKey:@"U_Photo1"]];
    self.UMTVURL = [self changeString:[attributes objectForKey:@"UMTVURL"]];

    
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
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetCardsItemList.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"ppppp:%@",responseObject);
//        id i=[responseObject valueForKeyPath:@"maxcount"];
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSCardItemSP"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSFactorypost *post=[[TSFactorypost alloc] initWithAttributes:(NSDictionary *)attributes];
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
