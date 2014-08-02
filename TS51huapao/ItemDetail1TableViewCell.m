//
//  ItemDetail1TableViewCell.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "ItemDetail1TableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "WebViewController.h"

@implementation ItemDetail1TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

//-(void)dealloc
//{
//    NSLog(@"dealloc");
//}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonMtvClick:(UIButton *)sender {
    
    WebViewController *_webVC = [[WebViewController alloc] init];
    _webVC.hidesBottomBarWhenPushed = YES;
    //    [_logsInfo_vc setInfo:content];
    [_webVC setUrlstr:_post.UMTVURL];
    [_sender.navigationController pushViewController:_webVC animated:YES];
}

-(void)setPost:(TSItemDetailPost *)post
{
    _post=post;
    
    _LaeblItemName.text=_post.ItemName;
    
    [_imagePhoto2 setImageWithURL:[NSURL URLWithString:_post.U_Photo2] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    if ([_post.UMTVURL hasPrefix:@"http"]) {
        [_buttonMtv setHidden:NO];
    }else{
        [_buttonMtv setHidden:YES];
    }
    
    
    if ([_post.Price isEqualToString:@""]) {
        _labelCurrentPrice.text=NSLocalizedString(@"kong", @"");
    }else{
        NSString *cp=[[NSString alloc]init];
        cp=[@"¥" stringByAppendingString:_post.Price];
        if (![_post.U_NEU_PriceNote isEqualToString:@""]) {
            cp=[cp stringByAppendingString:@"   ("];
            cp=[cp stringByAppendingString:_post.U_NEU_PriceNote];
            cp=[cp stringByAppendingString:@")  "];
        }
        if (![_post.stocksum isEqualToString:@""]) {
            cp=[cp stringByAppendingString:@"库存:"];
            cp=[cp stringByAppendingString:_post.stocksum];
            cp=[cp stringByAppendingString:@"箱"];
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:cp];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,[_post.Price length]+1)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"TrebuchetMS-Bold" size:25.0] range:NSMakeRange(1,[_post.Price length])];
        //_labelCurrentPrice.text=cp;
        _labelCurrentPrice.attributedText=str;
    }
    
    if (!_post.oldPrice.floatValue>0) {
        _labelOldPrice.text=[[@"¥" stringByAppendingString:post.Price] stringByAppendingString:@"/每箱"];;
    }else{
        _labelOldPrice.text=[[@"¥" stringByAppendingString:post.oldPrice] stringByAppendingString:@"/每箱"];
    }
    
    if ([_post.U_NEU_SaleType isEqualToString:@"直销"]) {
        if (post.CostPrice.floatValue>0 &&([TSUser sharedUser].USERTYPE==TSManager ||[TSUser sharedUser].USERTYPE==TSUnionClient)) {
            _zhixiaojia.text=[NSString stringWithFormat:@"直销价: %@元/箱",post.CostPrice];
            _zhixiaojia.hidden=NO;
        }else{
            _zhixiaojia.hidden=YES;
        }
    }else{
        _zhixiaojia.hidden=YES;
    }

    if ([TSUser sharedUser].USERTYPE==TSVender) {
        _labelCurrentPrice.hidden=YES;
        _labelOldPrice.hidden=YES;
    }else{
        _labelCurrentPrice.hidden=NO;
        _labelOldPrice.hidden=NO;
    }
}
@end
