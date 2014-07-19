//
//  TSRcmd.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-13.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSRcmd.h"

@implementation TSRcmd

- (void)setRcmd:(NSDictionary *)dic withKey:(NSString *)str
{
    _imageURL = [[dic objectForKey:str]objectForKey:@"imageurl"];
    _itemCode = [[dic objectForKey:str]objectForKey:@"itemcode"];
}

@end
