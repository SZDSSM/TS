//
//  TSdingdanpost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSdingdanpost.h"
#import "TSAppDoNetAPIClient.h"

@implementation TSdingdanpost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };

    self.DocDate = [self changeString:[attributes objectForKey:@"DocDate"]];
    self.DocEntry = [self changeString:[attributes objectForKey:@"DocEntry"]];
    self.CardCode = [self changeString:[attributes objectForKey:@"CardCode"]];
    self.CardName = [self changeString:[attributes objectForKey:@"CardName"]];
    self.Quantity = [self changeString:[attributes objectForKey:@"Quantity"]];
    self.OpenQty = [self changeString:[attributes objectForKey:@"OpenQty"]];
    self.DocTotal = [self changeString:[attributes objectForKey:@"DocTotal"]];
    self.DocStatus = [self changeString:[attributes objectForKey:@"DocStatus"]];
    self.U_NEU_DocTpe = [self changeString:[attributes objectForKey:@"U_NEU_DocTpe"]];
    self.U_NEU_drvr = [self changeString:[attributes objectForKey:@"U_NEU_drvr"]];
    self.U_NEU_MbTel = [self changeString:[attributes objectForKey:@"U_NEU_MbTel"]];
    self.U_NEU_Urgency = [self changeString:[attributes objectForKey:@"U_NEU_Urgency"]];
    self.U_RebateSUM = [self changeString:[attributes objectForKey:@"U_RebateSUM"]];
    self.Rebate = [self changeString:[attributes objectForKey:@"Rebate"]];
    
    self.ItemCode = [self changeString:[attributes objectForKey:@"ItemCode"]];
    self.ItemName = [self changeString:[attributes objectForKey:@"ItemName"]];
    self.Spec = [self changeString:[attributes objectForKey:@"Spec"]];
    self.U_Neu_Content = [self changeString:[attributes objectForKey:@"U_Neu_Content"]];
    self.Price = [self changeString:[attributes objectForKey:@"Price"]];
    self.LineTotal = [self changeString:[attributes objectForKey:@"LineTotal"]];
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

+(NSURLSessionDataTask *)globalTimeGetAnVipTradeConditionWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetAnVipTradeCondition.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TsVipTradeCondition"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSdingdanpost *post=[[TSdingdanpost alloc] initWithAttributes:(NSDictionary *)attributes];
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
