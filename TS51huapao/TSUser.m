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
#import "TSAppDoNetAPIClient.h"
#import "UIKit+AFNetworking.h"

@implementation TSUser

static TSUser* sharedUser = nil;

+(TSUser *) sharedUser{
    @synchronized(self){
        if (sharedUser == nil) {
            sharedUser = [[self alloc] init];
            sharedUser.LogStatus=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_LOG_IN];
            sharedUser.vipcode=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID];
            sharedUser.password=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_PASSWORD];
            sharedUser.U_name=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_NAME];
            sharedUser.JoinDate=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_JoinDate];
            sharedUser.JoinTime=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_JoinTime];
            
            
            sharedUser.U_age=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_AGE];
            sharedUser.U_email=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_EMAIL];
            sharedUser.U_gender=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_SEX];
            sharedUser.U_ismanager=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_IS_MANGER];
            sharedUser.U_type=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_TYPE];
            sharedUser.phone=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_PHONE];
            
            sharedUser.cardcode=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_CARDCODE];
            sharedUser.CARD_CardName=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_BUSINESS_CARDNAME];
            sharedUser.CARD_Address=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_BUSINESS_ADDRESS];
            sharedUser.CARD_CntctPrsn=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_BUSINESS_CONTACT];
            sharedUser.CARD_CntctPrsnCellolar=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_BUSINESS_Cellolar];
            sharedUser.CARD_Phone1=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_BUSINESS_PHONE];
            sharedUser.CARD_Position=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_BUSINESS_POSITON];
            sharedUser.CARD_Summary=[[NSUserDefaults standardUserDefaults] objectForKey:kMY_BUSINESS_Summary];
        }
    }
    return  sharedUser;
}

#pragma mark - setmetch
-(void)setVipcode:(NSString *)vipcode
{
    _vipcode=vipcode;
    [[NSUserDefaults standardUserDefaults]setObject:vipcode forKey:kMY_USER_ID];
}
-(void)setU_name:(NSString *)U_name
{
    _U_name=U_name;
    [[NSUserDefaults standardUserDefaults]setObject:U_name forKey:kMY_USER_NAME];
}
-(void)setPassword:(NSString *)password
{
    _password=password;
    [[NSUserDefaults standardUserDefaults]setObject:password forKey:kMY_USER_PASSWORD];
}
-(void)setJoinDate:(NSString *)JoinDate
{
    _JoinDate=JoinDate;
    [[NSUserDefaults standardUserDefaults]setObject:JoinDate forKey:kMY_USER_JoinDate];
}
-(void)setJoinTime:(NSString *)JoinTime
{
    _JoinTime=JoinTime;
    [[NSUserDefaults standardUserDefaults]setObject:JoinTime forKey:kMY_USER_JoinTime];
}
-(void)setU_age:(NSString *)U_age
{
    _U_age=U_age;
    [[NSUserDefaults standardUserDefaults]setObject:U_age forKey:kMY_USER_AGE];
}
-(void)setU_email:(NSString *)U_email
{
    _U_email=U_email;
    [[NSUserDefaults standardUserDefaults]setObject:U_email forKey:kMY_USER_EMAIL];
}
-(void)setU_gender:(NSString *)U_gender
{
    _U_gender=U_gender;
    [[NSUserDefaults standardUserDefaults]setObject:U_gender forKey:kMY_USER_SEX];
}
-(void)setU_ismanager:(NSString *)U_ismanager
{
    _U_ismanager=U_ismanager;
    [[NSUserDefaults standardUserDefaults]setObject:U_ismanager forKey:kMY_USER_IS_MANGER];
}
-(void)setU_type:(NSString *)U_type
{
    _U_type=U_type;
    [[NSUserDefaults standardUserDefaults]setObject:U_type forKey:kMY_USER_TYPE];
}
-(void)setPhone:(NSString *)phone
{
    _phone=phone;
    [[NSUserDefaults standardUserDefaults]setObject:phone forKey:kMY_USER_PHONE];
}
-(void)setCardcode:(NSString *)cardcode
{
    _cardcode=cardcode;
    [[NSUserDefaults standardUserDefaults]setObject:cardcode forKey:kMY_USER_CARDCODE];
}
//企业信息
-(void)setCARD_CardName:(NSString *)CARD_CardName
{
    _CARD_CardName=CARD_CardName;
    [[NSUserDefaults standardUserDefaults]setObject:CARD_CardName forKey:kMY_BUSINESS_CARDNAME];
}
-(void)setCARD_Address:(NSString *)CARD_Address
{
    _CARD_Address=CARD_Address;
    [[NSUserDefaults standardUserDefaults]setObject:CARD_Address forKey:kMY_BUSINESS_ADDRESS];
}
-(void)setCARD_CntctPrsn:(NSString *)CARD_CntctPrsn
{
    _CARD_CntctPrsn=CARD_CntctPrsn;
    [[NSUserDefaults standardUserDefaults]setObject:CARD_CntctPrsn forKey:kMY_BUSINESS_CONTACT];
}
-(void)setCARD_CntctPrsnCellolar:(NSString *)CARD_CntctPrsnCellolar
{
    _CARD_CntctPrsnCellolar=CARD_CntctPrsnCellolar;
    [[NSUserDefaults standardUserDefaults]setObject:CARD_CntctPrsnCellolar forKey:kMY_BUSINESS_Cellolar];
}
-(void)setCARD_Phone1:(NSString *)CARD_Phone1
{
    _CARD_Phone1=CARD_Phone1;
    [[NSUserDefaults standardUserDefaults]setObject:CARD_Phone1 forKey:kMY_BUSINESS_PHONE];
}
-(void)setCARD_Position:(NSString *)CARD_Position
{
    _CARD_Position=CARD_Position;
    [[NSUserDefaults standardUserDefaults]setObject:CARD_Position forKey:kMY_BUSINESS_POSITON];
}
-(void)setCARD_Summary:(NSString *)CARD_Summary
{
    _CARD_Summary=CARD_Summary;
    [[NSUserDefaults standardUserDefaults]setObject:CARD_Summary forKey:kMY_BUSINESS_Summary];
}

-(void)setLogStatus:(NSString *)LogStatus
{
    _LogStatus=LogStatus;
    [[NSUserDefaults standardUserDefaults]setObject:LogStatus forKey:kMY_LOG_IN];
}


-(void)getMyVipInfo
{
    NSURLSessionDataTask * task =[[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetAnVipInfo.ashx" parameters:@{@"vipcode":self.vipcode} success:^(NSURLSessionDataTask *task, id responseObject) {
        self.JoinDate=[responseObject objectForKey:@"JoinDate"];
        self.JoinTime=[responseObject objectForKey:@"JoinTime"];
        self.U_name=[responseObject objectForKey:@"U_name"];
        self.U_type=[responseObject objectForKey:@"U_type"];
        self.U_age=[responseObject objectForKey:@"U_age"];
        self.U_gender=[responseObject objectForKey:@"U_gender"];
        self.U_email=[responseObject objectForKey:@"U_email"];
        self.U_ismanager=[responseObject objectForKey:@"U_ismanager"];
        self.cardcode=[responseObject objectForKey:@"cardcode"];
        self.phone=[responseObject objectForKey:@"phone"];
//        self.vipcode=[responseObject objectForKey:@"vipcode"];
//        self.password=[responseObject objectForKey:@"password"];
    
        NSDictionary *dict=[responseObject objectForKey:@"U_CardInfo"];
        self.CARD_CardName=[dict objectForKey:@"CardName"];
        self.CARD_Address=[dict objectForKey:@"Address"];
        self.CARD_CntctPrsn=[dict objectForKey:@"CntctPrsn"];
        self.CARD_CntctPrsnCellolar=[dict objectForKey:@"CntctPrsnCellolar"];
        self.CARD_Phone1=[dict objectForKey:@"Phone1"];
        self.CARD_Position=[dict objectForKey:@"Position"];
        self.CARD_Summary=[dict objectForKey:@"Summary"];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}


@end
