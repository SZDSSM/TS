//
//  TSRcmd.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-13.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSRcmd : NSObject

@property (copy, nonatomic) NSString * imageURL;

@property (copy, nonatomic) NSString * itemCode;

- (void)setRcmd:(NSDictionary *)dic withKey:(NSString *)str;


@end
