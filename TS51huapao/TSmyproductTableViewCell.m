//
//  TSmyproductTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-8-2.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSmyproductTableViewCell.h"
#import "TSFactorypost.h"
#import "UIKit+AFNetworking.h"
#import "ItemDetailTableViewController.h"

@implementation TSmyproductTableViewCell

- (void)awakeFromNib
{
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:240.0/255.0] CGColor];
    [self.shadowView layer].borderWidth = 0.2;
}

- (void)setPost:(TSFactorypost *)post
{
    _post = post;
    /*NSString *cp=[[NSString alloc]init];
     cp=[@"¥" stringByAppendingString:_kanyangpost.Price];
     int len=_kanyangpost.Price.length+1;
     if (![_kanyangpost.costPrice isEqualToString:@""]&&[TSUser sharedUser].USERTYPE==TSManager) {
     cp=[cp stringByAppendingString:@"("];
     cp=[cp stringByAppendingString:_kanyangpost.costPrice];
     cp=[cp stringByAppendingString:@")"];
     len=len+_kanyangpost.costPrice.length+2;
     }
     cp=[cp stringByAppendingString:@"元/箱"];
     if (![_kanyangpost.stocksum isEqualToString:@""]) {
     cp=[cp stringByAppendingString:@"  "];
     cp=[cp stringByAppendingString:_kanyangpost.stocksum];
     cp=[cp stringByAppendingString:@"箱"];
     }
     NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:cp];
     [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,len)];
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,len)];
     _price.attributedText=str;*/
    
    NSString *cp=[[NSString alloc]init];
    cp=[@"¥" stringByAppendingString:_post.Price];
    NSUInteger len=_post.Price.length+1;
    
    cp=[cp stringByAppendingString:@"元/箱"];
    if (![_post.VendorOnhand isEqualToString:@""]) {
        cp=[cp stringByAppendingString:@"  "];
        cp=[cp stringByAppendingString:_post.VendorOnhand];
        cp=[cp stringByAppendingString:@"箱"];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:cp];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,len)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,len)];
    _price.attributedText=str;
    
    self.itemname.text = _post.ItemName;
    self.spec.text = _post.Spec;
    
    [self.itemimage setImageWithURL:[NSURL URLWithString:_post.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)pushtoItemDetailView
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailTableViewController *itemdetail = [board instantiateViewControllerWithIdentifier:@"tsItemdetail"];
    itemdetail.itemcode=_post.ItemCode;
    [_sender.navigationController pushViewController:itemdetail animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
