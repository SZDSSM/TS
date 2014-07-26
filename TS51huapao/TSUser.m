//
//  TSUser.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-24.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//
/* "JoinDate": "2014-07-18",
 "JoinTime": "17:11",
 "U_CardInfo": {
 "Address": "浏阳市北正北路368号",
 "CardName": "浏阳市德森烟花有限公司",
 "CntctPrsn": "陶维强",
 "CntctPrsnCellolar": "15874021111",
 "Phone1": "15874021111",
 "Position": "",
 "Summary": ""
 },
 "U_age": "26",
 "U_email": "fx5858810@qq.com",
 "U_gender": "男",
 "U_ismanager": "否",
 "U_name": "冯翔",
 "U_type": "51管理",
 "cardcode": "s0381",
 "password": "fengxiang",
 "phone": "13590166783",
 "vipcode": "13590166783"*/

#import "TSUser.h"

@implementation TSUser

static TSUser* sharedUser = nil;

+(TSUser *) sharedUser{
    @synchronized(self){
        if (sharedUser == nil) {
            sharedUser = [[self alloc] init];
        }
    }
    return  sharedUser;
}



@end
