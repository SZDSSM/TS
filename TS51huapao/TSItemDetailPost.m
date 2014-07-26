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
    self.CostPrice=[self changeString:[attributes valueForKeyPath:@"CostPrice"]];//原价
    self.Effect=[self changeString:[attributes valueForKeyPath:@"Effect"]];
    self.IsEnsure=[self changeString:[attributes valueForKeyPath:@"IsEnsure"]];
    self.IsFreeShip=[self changeString:[attributes valueForKeyPath:@"IsFreeShip"]];
    self.IsHot=[self changeString:[attributes valueForKeyPath:@"IsHot"]];
    self.IsNewPrdct=[self changeString:[attributes valueForKeyPath:@"IsNewPrdct"]];
    self.IsQaTest=[self changeString:[attributes valueForKeyPath:@"IsQaTest"]];
    self.IsStroe=[self changeString:[attributes valueForKeyPath:@"IsStroe"]];
    self.IsTrade=[self changeString:[attributes valueForKeyPath:@"IsTrade"]];
    self.ItemCode=[self changeString:[attributes valueForKeyPath:@"ItemCode"]];
    self.ItemName=[self changeString:[attributes valueForKeyPath:@"ItemName"]];
    self.ItmsGrpNam=[self changeString:[attributes valueForKeyPath:@"ItmsGrpNam"]];
    self.Price=[self changeString:[attributes valueForKeyPath:@"Price"]];
    self.SalesVolume=[self changeString:[attributes valueForKeyPath:@"SalesVolume"]];
    self.Spec=[self changeString:[attributes valueForKeyPath:@"Spec"]];
    self.UMTVURL=[self changeString:[attributes valueForKeyPath:@"UMTVURL"]];
    self.U_NEU_PriceNote=[self changeString:[attributes valueForKeyPath:@"U_NEU_PriceNote"]];
    self.U_NEU_Rebate=[attributes valueForKeyPath:@"U_NEU_Rebate"];
    self.U_NEU_RoughWeight=[self changeString:[attributes valueForKeyPath:@"U_NEU_RoughWeight"]];
    self.U_NEU_SaleType=[self changeString:[attributes valueForKeyPath:@"U_NEU_SaleType"]];
    self.U_NEU_boxboard=[self changeString:[attributes valueForKeyPath:@"U_NEU_boxboard"]];
    self.U_NEU_cuxiao=[self changeString:[attributes valueForKeyPath:@"U_NEU_cuxiao"]];
    self.U_Neu_Content=[self changeString:[attributes valueForKeyPath:@"U_Neu_Content"]];
    self.U_Photo1=[self changeString:[attributes valueForKeyPath:@"U_Photo1"]];
    self.U_Photo2=[self changeString:[attributes valueForKeyPath:@"U_Photo2"]];
    self.U_clicksum=[self changeString:[attributes valueForKeyPath:@"U_clicksum"]];
    self.cardcode=[self changeString:[attributes valueForKeyPath:@"cardcode"]];
    self.cardname=[self changeString:[attributes valueForKeyPath:@"cardname"]];
    
    
    self.miaoshu=[self changeString:[attributes valueForKeyPath:@"miaoshu"]];
    self.shuoming=[self changeString:[attributes valueForKeyPath:@"shuoming"]];
    
    self.photolist=[attributes valueForKeyPath:@"photolist"];
    self.stocksum=[self changeString:[attributes valueForKeyPath:@"stocksum"]];//库存
   

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
