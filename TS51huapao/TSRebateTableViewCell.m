//
//  TSRebateTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-29.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSRebateTableViewCell.h"


@implementation TSRebateTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setDingdanpost:(TSdingdanpost *)dingdanpost
{
    _dingdanpost = dingdanpost;
        
    self.cardname.text = _dingdanpost.CardName;
    self.rebate.text = [NSString stringWithFormat:@"¥%@",_dingdanpost.Rebate];
    self.rebateSum.text = [NSString stringWithFormat:@"¥%@",_dingdanpost.U_RebateSUM];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
