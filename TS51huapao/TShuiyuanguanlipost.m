//
//  TShuiyuanguanlipost.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TShuiyuanguanlipost.h"
#import "TSAppDoNetAPIClient.h"

@implementation TShuiyuanguanlipost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    
    self.code = [self changeString:[attributes objectForKey:@"code"]];
    self.phone = [self changeString:[attributes objectForKey:@"phone"]];
    self.cardName = [self changeString:[attributes objectForKey:@"cardName"]];
    self.U_type = [self changeString:[attributes objectForKey:@"U_type"]];
    self.U_name = [self changeString:[attributes objectForKey:@"U_name"]];
    self.JoinDateTime = [self changeString:[attributes objectForKey:@"JoinDateTime"]];
    self.status = [self changeString:[attributes objectForKey:@"status"]];
    
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

+(NSURLSessionDataTask *)globalTimeGetVipListWithDictionary:(NSDictionary*)parameters Block:(void(^)(NSArray *post,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetVipList.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"TsVipList"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TShuiyuanguanlipost *post=[[TShuiyuanguanlipost alloc] initWithAttributes:(NSDictionary *)attributes];
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
