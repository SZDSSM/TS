//
//  TSItemTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-13.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSItemTableViewCell.h"
#import "TSItemListPost.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+Style.h"

@implementation TSItemTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(TSItemListPost *)post
{
    _post = post;
//    [self.guanzhu setTintColor:[UIColor redColor]];
    [self.guanzhu guzhuqianStyle];
    
    self.itemname.text = _post.ItemName;
    self.Spec.text = _post.Spec;
    self.Price.text = _post.Price;
    if (![_post.IsOTO isEqualToString:@"Y"]) {
        self.zhixiao.hidden = YES;
    }
    if (![_post.IsRebate isEqualToString:@"Y"]) {
        self.fanli.hidden = YES;
    }
    if (![_post.IsStroe isEqualToString:@"Y"]) {
        
    }
    [self.itemimage setImageWithURL:[NSURL URLWithString:_post.U_Photo1] placeholderImage:[UIImage imageNamed:@" "]];
    
    
    
}

- (IBAction)guanzhu:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"☆"]) {
        [sender guzhuqianStyle];
    }else{
        [sender guzhuhouStyle];
    }
    
}
@end
