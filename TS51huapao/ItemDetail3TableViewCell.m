//
//  ItemDetail3TableViewCell.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "ItemDetail3TableViewCell.h"
#import "UIButton+Style.h"
#import "TSAppDoNetAPIClient.h"

@implementation ItemDetail3TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonStorClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"☆"]) {
        [[TSAppDoNetAPIClient sharedClient] GET:@"FoxStorUpItem.ashx" parameters:@{@"vipcode":[TSUser sharedUser].vipcode,@"itemcode":_post.ItemCode} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *rslt=[responseObject objectForKey:@"result"];
            if ([rslt isEqualToString:@"true"]) {
                [_post setIsStroe:@"Y"];
                [sender guzhuhouStyle];
                if ([_delegate respondsToSelector:@selector(guanZhuButtonClicked:)]) {
                    [_delegate guanZhuButtonClicked:YES];
                }
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"成功"
                                          message:@"添加至我的收藏"
                                          delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:0.6f
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:alertView
                                                repeats:NO];
                [alertView show];
            }else if ([rslt isEqualToString:@"false"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"失败"
                                          message:@"添加收藏失败"
                                          delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:0.6f
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:alertView
                                                repeats:NO];
                [alertView show];
            }else if ([rslt isEqualToString:@"repetition"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"该物料已在我的收藏列表"
                                          delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:0.6f
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:alertView
                                                repeats:NO];
                [alertView show];
            }else if ([rslt isEqualToString:@"notExists"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"该物料不存在"
                                          delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:0.6f
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:alertView
                                                repeats:NO];
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
    }else{
        [[TSAppDoNetAPIClient sharedClient] GET:@"FoxDelStorUpItem.ashx" parameters:@{@"vipcode":[TSUser sharedUser].vipcode,@"itemcode":_post.ItemCode} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *rslt=[responseObject objectForKey:@"result"];
            if ([rslt isEqualToString:@"true"]) {
                [_post setIsStroe:@"N"];
                [sender guzhuqianStyle];
                if ([_delegate respondsToSelector:@selector(guanZhuButtonClicked:)]) {
                    [_delegate guanZhuButtonClicked:NO];
                }
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"成功"
                                          message:@"移除该收藏"
                                          delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:0.6f
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:alertView
                                                repeats:NO];
                [alertView show];
            }else if ([rslt isEqualToString:@"false"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"失败"
                                          message:@"删除操作失败"
                                          delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:0.6f
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:alertView
                                                repeats:NO];
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
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

-(void)setPost:(TSItemDetailPost *)post
{
    _post=post;
    
    if ([_post.U_NEU_cuxiao isEqualToString:@""]) {
        _labelSalesPromInfo.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelSalesPromInfo.text=_post.U_NEU_cuxiao;
    }
    
    if (![_post.U_NEU_SaleType isEqualToString:@"直销"]) {
        if (!_post.U_NEU_Rebate.intValue >0) {
            _image1.hidden=YES;
            _image2.hidden=YES;
        }else{
            [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
            _image1.hidden=NO;
            _image2.hidden=YES;
        }
        
    }
    else
    {
        if (!_post.U_NEU_Rebate.intValue >0) {
            [_image1 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
            _image1.hidden=NO;
            _image2.hidden=YES;
        }else{
            [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
            [_image2 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
            _image1.hidden=NO;
            _image2.hidden=NO;
        }
    }
    
    if ([_post.IsStroe isEqualToString:@"Y"]) {
        [_buttonStor guzhuhouStyle];
    }else{
        [_buttonStor guzhuqianStyle];
    }
}
@end
