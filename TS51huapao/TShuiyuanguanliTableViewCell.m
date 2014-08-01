//
//  TShuiyuanguanliTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TShuiyuanguanliTableViewCell.h"
#import "UIButton+Style.h"
#import "TSAppDoNetAPIClient.h"

@implementation TShuiyuanguanliTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setHuiyuanpost:(TShuiyuanguanlipost *)huiyuanpost
{
    _huiyuanpost = huiyuanpost;
    self.cardName.text = [NSString stringWithFormat:@"%@(%@)",_huiyuanpost.cardName,_huiyuanpost.U_type];
    self.contectPerson.text = _huiyuanpost.U_name;
    self.phoneNumber.text = _huiyuanpost.phone;
    self.date.text = _huiyuanpost.JoinDateTime;
    [self.headimage setImage:[UIImage imageNamed:@"2.jpg"]];
    [self.guanbi cancelAttentionStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)gubi:(id)sender {
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxCheckAnVipApl.ashx" parameters:@{@"vipcode":_huiyuanpost.code,@"agree":@"N"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"拒绝"
                                      message:@"已拒绝该用户申请"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
            //            [_sender removeFormPosts:_kanyangpost];
        }else if ([rslt isEqualToString:@"false"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"拒绝操作失败"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            
            [alertView show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:[error localizedDescription]
                                  delegate:nil
                                  cancelButtonTitle:@"关闭"
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

@end
