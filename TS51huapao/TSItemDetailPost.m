//
//  TSItemDetailPost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSItemDetailPost.h"
#import "TSAppDoNetAPIClient.h"


@implementation TSItemDetailPost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    self.CostPrice=[attributes valueForKeyPath:@"CostPrice"];//原价
    self.Effect=[attributes valueForKeyPath:@"Effect"];
    self.IsEnsure=[attributes valueForKeyPath:@"IsEnsure"];
    self.IsFreeShip=[attributes valueForKeyPath:@"IsFreeShip"];
    self.IsHot=[attributes valueForKeyPath:@"IsHot"];
    self.IsNewPrdct=[attributes valueForKeyPath:@"IsNewPrdct"];
    self.IsQaTest=[attributes valueForKeyPath:@"IsQaTest"];
    self.IsStroe=[attributes valueForKeyPath:@"IsStroe"];
    self.IsTrade=[attributes valueForKeyPath:@"IsTrade"];
    self.ItemCode=[attributes valueForKeyPath:@"ItemCode"];
    self.ItemName=[attributes valueForKeyPath:@"ItemName"];
    self.ItmsGrpNam=[attributes valueForKeyPath:@"ItmsGrpNam"];
    self.Price=[attributes valueForKeyPath:@"Price"];
    self.SalesVolume=[attributes valueForKeyPath:@"SalesVolume"];
    self.Spec=[attributes valueForKeyPath:@"Spec"];
    self.UMTVURL=[attributes valueForKeyPath:@"UMTVURL"];
    self.U_NEU_PriceNote=[attributes valueForKeyPath:@"U_NEU_PriceNote"];
    self.U_NEU_Rebate=[attributes valueForKeyPath:@"U_NEU_Rebate"];
    self.U_NEU_RoughWeight=[attributes valueForKeyPath:@"U_NEU_RoughWeight"];
    if ([attributes valueForKeyPath:@"U_NEU_SaleType"] != [NSNull null]) {
        self.U_NEU_SaleType=[attributes valueForKeyPath:@"U_NEU_SaleType"];
    }else
    {self.U_NEU_SaleType=@"空";}
    self.U_NEU_boxboard=[attributes valueForKeyPath:@"U_NEU_boxboard"];
    self.U_NEU_cuxiao=[attributes valueForKeyPath:@"U_NEU_cuxiao"];
    self.U_Neu_Content=[attributes valueForKeyPath:@"U_Neu_Content"];
    self.U_Photo1=[attributes valueForKeyPath:@"U_Photo1"];
    self.U_Photo2=[attributes valueForKeyPath:@"U_Photo2"];
    self.U_clicksum=[attributes valueForKeyPath:@"U_clicksum"];
    self.cardcode=[attributes valueForKeyPath:@"cardcode"];
    self.cardname=[attributes valueForKeyPath:@"cardname"];
    self.photolist=[attributes valueForKeyPath:@"photolist"];
    self.stocksum=[attributes valueForKeyPath:@"stocksum"];//库存
   

    return self;
}

+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithItemcode:(NSString *)itemcode Block:(void(^)(TSItemDetailPost *post,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetAnItemData.ashx" parameters:@{@"itemcode":itemcode} success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"ppppp:%@",responseObject);
        TSItemDetailPost *post=[[TSItemDetailPost alloc] initWithAttributes:(NSDictionary *)responseObject];
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
