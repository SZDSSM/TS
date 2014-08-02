//
//  TSyixiangdingdanTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//
#import "ItemDetailTableViewController.h"
#import "TSyixiangdingdanTableViewCell.h"
#import "UIButton+Style.h"
#import "UIImageView+AFNetworking.h"
#import "TSAppDoNetAPIClient.h"
@implementation TSyixiangdingdanTableViewCell
- (void)awakeFromNib
{
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0] CGColor];
    [self.shadowView layer].borderWidth = 0.2;
}
/*
 @property (weak, nonatomic) IBOutlet UIImageView *itemimage;
 @property (weak, nonatomic) IBOutlet UIImageView *shadowView;
 @property (weak, nonatomic) IBOutlet UILabel *itemname;
 @property (weak, nonatomic) IBOutlet UILabel *specContent;
 @property (weak, nonatomic) IBOutlet UILabel *price;
 @property (weak, nonatomic) IBOutlet UILabel *quantity;
 @property (weak, nonatomic) IBOutlet UILabel *date;
 @property (weak, nonatomic) IBOutlet UILabel *contectperson;
 @property (weak, nonatomic) IBOutlet UILabel *phoneNumeber;
 @property (weak, nonatomic) IBOutlet UILabel *kucun;
 */

- (void)setYixiangdingdanpost:(TSItemListPost *)yixiangdingdanpost
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    _yixiangdingdanpost = yixiangdingdanpost;
    [_status yuyueStyle];
    if ([yixiangdingdanpost.status isEqualToString:@"0"]) {
        [_status setTitle:@"等待处理" forState:UIControlStateNormal];
    }else if ([yixiangdingdanpost.status isEqualToString:@"1"]) {
        [_status setTitle:@"处理中" forState:UIControlStateNormal];
    }else if ([yixiangdingdanpost.status isEqualToString:@"2"]) {
        [_status setTitle:@"已转订单" forState:UIControlStateNormal];
    }else if ([yixiangdingdanpost.status isEqualToString:@"3"]) {
        [_status setTitle:@"关闭" forState:UIControlStateNormal];
    }
    self.itemname.text = _yixiangdingdanpost.ItemName;
    self.specContent.text = [NSString stringWithFormat:@"规格:%@\t含量:%@",_yixiangdingdanpost.Spec,_yixiangdingdanpost.U_Neu_Content];
    
    
    //self.price.text
    NSString *cp= _yixiangdingdanpost.Price;
    if (![_yixiangdingdanpost.costPrice isEqualToString:@""]&&[TSUser sharedUser].USERTYPE==TSManager) {
        cp=[cp stringByAppendingString:@"("];
        cp=[cp stringByAppendingString:_yixiangdingdanpost.costPrice];
        cp=[cp stringByAppendingString:@")"];
    }
    _price.text=[cp stringByAppendingString:@"元/箱"];
    
    self.quantity.text = _yixiangdingdanpost.quantity;
    self.date.text = _yixiangdingdanpost.StorDateTime;
    self.contectperson.text = _yixiangdingdanpost.vipname;
    self.phoneNumeber.text = _yixiangdingdanpost.Vipcode;
    self.kucun.text = _yixiangdingdanpost.stocksum;
    self.cardname.text=_yixiangdingdanpost.cardname;
    [self.itemimage setImageWithURL:[NSURL URLWithString:_yixiangdingdanpost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)pushtoItemDetailView
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailTableViewController *itemdetail = [board instantiateViewControllerWithIdentifier:@"tsItemdetail"];
    itemdetail.itemcode=_yixiangdingdanpost.itemCode;
    [itemdetail xiadanCallback:^(int orderQty){
        if (orderQty==0) {
            [_sender removeFormPosts:_yixiangdingdanpost];
        }else if(orderQty>0){
            _quantity.text=[NSString stringWithFormat:@"%d",orderQty];
            [_yixiangdingdanpost setQuantity:_quantity.text];
        }
    }];
    [_sender.navigationController pushViewController:itemdetail animated:YES];
}


- (IBAction)changeStatus:(id)sender {
    if ([TSUser sharedUser].USERTYPE==TSManager) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"删除该条意向订单"
                                      otherButtonTitles:@"转为处理中",@"转为已转订单",@"转为等待处理",@"转为关闭",nil];
        actionSheet.actionSheetStyle =  UIActionSheetStyleAutomatic;
        [actionSheet showInView:_sender.view];
    }
}
#pragma  mark-- 实现UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self changeOrderItemStatus:@"D" callback:^{
            [_sender removeFormPosts:_yixiangdingdanpost];
        }];
    }else if(buttonIndex==1){
        [self changeOrderItemStatus:@"T" callback:^{
            [_yixiangdingdanpost setStatus:@"1"];
            [_status setTitle:@"处理中" forState:UIControlStateNormal];
        }];
    }else if(buttonIndex==2){
        [self changeOrderItemStatus:@"C" callback:^{
            [_yixiangdingdanpost setStatus:@"2"];
            [_status setTitle:@"已转订单" forState:UIControlStateNormal];
        }];
    }else if(buttonIndex==3){
        [self changeOrderItemStatus:@"O" callback:^{
            [_yixiangdingdanpost setStatus:@"0"];
            [_status setTitle:@"等待处理" forState:UIControlStateNormal];
        }];
    }else if(buttonIndex==4){
        [self changeOrderItemStatus:@"Z" callback:^{
            [_yixiangdingdanpost setStatus:@"3"];
            [_status setTitle:@"关闭" forState:UIControlStateNormal];
        }];
    }
}
-(void)changeOrderItemStatus:(NSString*)type callback:(void (^)())callback;
{
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxUpateAnOrderItemStatus.ashx" parameters:@{@"type":type,@"vipcode":_yixiangdingdanpost.Vipcode,@"LineId":_yixiangdingdanpost.lineid} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"成功"
                                      message:@"操作成功"
                                      delegate:self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil, nil];
            [alertView show];
            if (callback) {
                callback();
            }
        }else  {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"操作失败"
                                      delegate:nil
                                      cancelButtonTitle:@"确定"
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
