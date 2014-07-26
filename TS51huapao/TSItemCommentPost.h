//
//  TSItemCommentPost.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSItemCommentPost : NSObject


@property (strong, nonatomic) NSString * vipcode;
@property (strong, nonatomic) NSString * comment;
@property (strong, nonatomic) NSString * commentdate;
@property (assign, nonatomic) float leve;

+(NSURLSessionDataTask *)globalTimeGetCommentInfoWithItemcode:(NSString *)itemcode Block:(void(^)(NSArray * posts,NSString *reputably,NSError *error))block;

@end
