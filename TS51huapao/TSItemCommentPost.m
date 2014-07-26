//
//  TSItemCommentPost.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSItemCommentPost.h"
#import "TSAppDoNetAPIClient.h"


@implementation TSItemCommentPost

-(instancetype)initWithAttributes:(NSDictionary *)attributes{
    self=[super init];
    if(!self){
        return nil;
    };
    self.vipcode = [self changeString:[attributes valueForKey:@"vipcode"]];
    self.comment = [self changeString:[attributes valueForKey:@"comment"]];
    self.commentdate = [self changeString:[attributes valueForKey:@"commentdate"]];
    
    @try {
        NSNumber *num=[attributes valueForKey:@"leve"];
        self.leve =num.floatValue;
    }
    @catch (NSException *exception) {
        self.leve =0.0;
    }
    @finally {
    }

    
    return self;
}

- (NSString *)changeString:(NSString *)sender
{
    NSString * str = [NSString string];
    str = [NSString stringWithFormat:@"%@",sender];
    if ([str isKindOfClass:[NSNull class]]){
        str = @" ";
    }
    return str;
}

+(NSURLSessionDataTask *)globalTimeGetCommentInfoWithItemcode:(NSString *)itemcode Block:(void(^)(NSArray * posts,NSString *reputably,NSError *error))block{
    return [[TSAppDoNetAPIClient sharedClient] GET:@"GetAnItemCommentInfoList.ashx" parameters:@{@"itemcode":itemcode} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *reputably = [responseObject valueForKeyPath:@"reputably"];
        NSArray * postsFromResponse = [responseObject valueForKeyPath:@"ItemComment"];
        NSMutableArray * mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary * attributes in postsFromResponse) {
            TSItemCommentPost *post=[[TSItemCommentPost alloc] initWithAttributes:(NSDictionary *)attributes];
            [mutablePosts addObject:post];
        }
        if(block){
            block([NSArray arrayWithArray:mutablePosts],reputably,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block([NSArray array],@"",error);
        }
    }];
}
@end
