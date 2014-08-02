//
//  TSdanjuxiangqingTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-27.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSdanjuxiangqingTableViewCell.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "ItemDetailTableViewController.h"

@implementation TSdanjuxiangqingTableViewCell

- (void)awakeFromNib
{
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1] CGColor];
    [self.shadowView layer].borderWidth = 0.2;
}

- (void)setDanjuxiangqingpost:(TSdanjuxiangqingpost *)danjuxiangqingpost
{
    _danjuxiangqingpost = danjuxiangqingpost;
   
    self.itemname.text = _danjuxiangqingpost.ItemName;
    
    self.unitprice.text = [NSString stringWithFormat:@"¥%.2f",[_danjuxiangqingpost.Price floatValue]];
    self.priceSum.text = [NSString stringWithFormat:@"¥%@",_danjuxiangqingpost.Total];
    self.quantity.text = [NSString stringWithFormat:@"%@",_danjuxiangqingpost.Quantity];
    self.openQuantity.text = [NSString stringWithFormat:@"%@",_danjuxiangqingpost.OpenQty];
    
    [self.itemimage setImageWithURL:[NSURL URLWithString:_danjuxiangqingpost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)pushtoItemDetailView
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailTableViewController *itemdetail = [board instantiateViewControllerWithIdentifier:@"tsItemdetail"];
    itemdetail.itemcode=_danjuxiangqingpost.ItemCode;
    [_sender.navigationController pushViewController:itemdetail animated:YES];
}

@end
