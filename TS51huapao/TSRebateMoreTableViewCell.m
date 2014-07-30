//
//  TSRebateMoreTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-29.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSRebateMoreTableViewCell.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@implementation TSRebateMoreTableViewCell

- (void)awakeFromNib
{
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1] CGColor];
    [self.shadowView layer].borderWidth = 0.2;
}

- (void)setDingdanpost:(TSdingdanpost *)dingdanpost
{
    _dingdanpost = dingdanpost;
    
    self.cardname.text = _dingdanpost.ItemName;
    
    self.singlerebate.text = [NSString stringWithFormat:@"¥%@",_dingdanpost.Rebate];
    self.rebateSum.text = [NSString stringWithFormat:@"¥%.2f",[_dingdanpost.Rebate floatValue]*[_dingdanpost.Quantity intValue]];
    self.content.text = [NSString stringWithFormat:@"%@",_dingdanpost.U_Neu_Content];
    self.spec.text = [NSString stringWithFormat:@"%@",_dingdanpost.Spec];
    
    [self.itemimage setImageWithURL:[NSURL URLWithString:_dingdanpost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noimage"]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
