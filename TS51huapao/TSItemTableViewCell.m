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
#import "TSFactorypost.h"

@interface TSItemTableViewCell ()

@property(nonatomic,assign) NSInteger iconNumbers;
@property(nonatomic,assign) CGRect nextRect;
@end

@implementation TSItemTableViewCell


- (void)awakeFromNib
{
    // Initialization code
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:240.0/255.0] CGColor];
    [self.shadowView layer].borderWidth = 1.0f;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setPost:(TSItemListPost *)post
{
    _post = post;
    
    _iconNumbers=0;
//    [self.guanzhu setTintColor:[UIColor redColor]];
    [self.guanzhu guzhuqianStyle];
    
    self.itemname.text = _post.ItemName;
    self.Spec.text = _post.Spec;
    self.Price.text = _post.Price;
    
    

    if (![_post.IsRebate isEqualToString:@"Y"]) {
        self.fanli.hidden = YES;
        //[_fanli setBackgroundImage:nil];
    }else{
        self.fanli.hidden = NO;
        //[_fanli setBackgroundImage:[UIImage imageNamed:@"ic_fanlianniu"] forState:UIControlStateNormal];
        _iconNumbers++;
    }
    
    if (![_post.IsOTO isEqualToString:@"Y"]) {
        self.zhixiao.hidden = YES;
    }else{
        self.zhixiao.hidden = NO;
        _iconNumbers++;
    }
    
    if (![post.UMTVURL hasPrefix:@"http"]) {
        _mtv.hidden=YES;
    }else{
        _mtv.hidden=NO;
    }
    
    if (![_post.IsStroe isEqualToString:@"Y"]) {
        
    }
    [self.itemimage setImageWithURL:[NSURL URLWithString:_post.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
}

- (void)setThirdPageFacPost:(TSFactorypost *)thirdPageFacPost
{
    _thirdPageFacPost = thirdPageFacPost;
    
    _iconNumbers=0;
    //    [self.guanzhu setTintColor:[UIColor redColor]];
    [self.guanzhu guzhuqianStyle];
    
    self.itemname.text = _thirdPageFacPost.ItemName;
    self.Spec.text = _thirdPageFacPost.Spec;
    self.Price.text = _thirdPageFacPost.Price;
    
    
    
    if (![_thirdPageFacPost.IsRebate isEqualToString:@"Y"]) {
        self.fanli.hidden = YES;
        //[_fanli setBackgroundImage:nil];
    }else{
        self.fanli.hidden = NO;
        //[_fanli setBackgroundImage:[UIImage imageNamed:@"ic_fanlianniu"] forState:UIControlStateNormal];
        _iconNumbers++;
    }
    
    if (![_thirdPageFacPost.IsOTO isEqualToString:@"Y"]) {
        self.zhixiao.hidden = YES;
    }else{
        self.zhixiao.hidden = NO;
        _iconNumbers++;
    }
    
    if (![thirdPageFacPost.UMTVURL hasPrefix:@"http"]) {
        _mtv.hidden=YES;
    }else{
        _mtv.hidden=NO;
    }
    
    if (![_thirdPageFacPost.IsStroe isEqualToString:@"Y"]) {
        
    }
    [self.itemimage setImageWithURL:[NSURL URLWithString:_thirdPageFacPost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
}


- (IBAction)guanzhu:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"☆"]) {
        [sender guzhuqianStyle];
    }else{
        [sender guzhuhouStyle];
    }
    
}
@end
