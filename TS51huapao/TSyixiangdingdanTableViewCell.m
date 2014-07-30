//
//  TSyixiangdingdanTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSyixiangdingdanTableViewCell.h"
#import "UIButton+Style.h"
#import "UIImageView+AFNetworking.h"

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
    
    self.itemname.text = _yixiangdingdanpost.ItemName;
    self.specContent.text = [NSString stringWithFormat:@"规格:%@\t含量:%@",_yixiangdingdanpost.Spec,_yixiangdingdanpost.U_Neu_Content];
    self.price.text = _yixiangdingdanpost.Price;
    self.quantity.text = _yixiangdingdanpost.quantity;
    self.date.text = _yixiangdingdanpost.StorDateTime;
    self.contectperson.text = _yixiangdingdanpost.vipname;
    self.phoneNumeber.text = _yixiangdingdanpost.Vipcode;
    self.kucun.text = _yixiangdingdanpost.stocksum;
    
    [self.itemimage setImageWithURL:[NSURL URLWithString:_yixiangdingdanpost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
