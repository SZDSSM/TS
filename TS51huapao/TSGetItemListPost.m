//
//  TSGetItemListPost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-20.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSGetItemListPost.h"
#import "TSAppDoNetAPIClient.h"

@implementation TSGetItemListPost

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
    self.oldPrice = [self changeString:[attributes valueForKey:@"OldPrice"]];

    
    self.U_Neu_Content = [self changeString:[attributes valueForKey:@"U_Neu_Content"]];
    self.IsOTO = [self changeString:[attributes valueForKey:@"IsOTO"]];
    self.IsRebate = [self changeString:[attributes valueForKey:@"IsRebate"]];
    self.IsStroe = [self changeString:[attributes valueForKey:@"IsStroe"]];
    self.U_Photo1 = [self changeString:[attributes valueForKey:@"U_Photo1"]];
    self.UMTVURL = [self changeString:[attributes valueForKey:@"UMTVURL"]];
    
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



+(NSURLSessionDataTask *)globalTimeGetRecommendInfoWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSUInteger maxcount,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetItemListSP.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"ppppp:%@",responseObject);
        //        id i=[responseObject valueForKeyPath:@"maxcount"];
        NSNumber *max = [responseObject valueForKeyPath:@"maxcount"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TSItemSP"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSGetItemListPost *post=[[TSGetItemListPost alloc] initWithAttributes:(NSDictionary *)attributes];
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
