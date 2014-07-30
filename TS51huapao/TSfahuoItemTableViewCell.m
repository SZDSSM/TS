//
//  TSfahuoItemTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSfahuoItemTableViewCell.h"

@implementation TSfahuoItemTableViewCell

- (void)awakeFromNib
{
   
}

- (void)setDingdanpost:(TSdingdanpost *)dingdanpost
{
    _dingdanpost = dingdanpost;
    
    //    [self.guanzhu setTintColor:[UIColor redColor]];
    
    self.date.text = _dingdanpost.DocDate;
    self.name.text = _dingdanpost.CardName;
    self.quantity.text = [NSString stringWithFormat:@"%@",_dingdanpost.Quantity];
    
    self.priceSum.text = [NSString stringWithFormat:@"%@",_dingdanpost.DocTotal];
    self.danhao.text =[NSString stringWithFormat:@"单号:%@",_dingdanpost.DocEntry];
    self.status.text = [NSString stringWithFormat:@"状态:%@",_dingdanpost.DocStatus];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
