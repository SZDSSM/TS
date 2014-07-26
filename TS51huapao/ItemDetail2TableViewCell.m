//
//  ItemDetail2TableViewCell.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//
#import "UIButton+Style.h"
#import "ItemDetail2TableViewCell.h"

@implementation ItemDetail2TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonProviderClick:(UIButton *)sender {
}

-(void)setPost:(TSItemDetailPost *)post
{
    _post=post;
    
    if ([_post.Spec isEqualToString:@""]) {
        _labelSpec.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelSpec.text=_post.Spec;
    }
    
    if ([_post.U_Neu_Content isEqualToString:@""]) {
        _labelContent.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelContent.text=_post.U_Neu_Content;
    }
    
    if ([_post.U_NEU_boxboard isEqualToString:@""]) {
        _labelBoxSepc.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelBoxSepc.text=_post.U_NEU_boxboard;
    }
    
    if ([_post.U_NEU_RoughWeight isEqualToString:@""]) {
        _labelRoughtWeight.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelRoughtWeight.text=_post.U_NEU_RoughWeight;
    }
    
    if ([_post.miaoshu isEqualToString:@""]) {
        _labelItemDescr.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelItemDescr.text=_post.miaoshu;
    }
    
    if ([_post.shuoming isEqualToString:@""]) {
        _labelItemExplain.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelItemExplain.text=_post.shuoming;
    }
    
    if ([_post.cardcode isEqualToString:@""]) {
        [_buttonProvider setTitle:NSLocalizedString(@"kong", @"") forState:UIControlStateNormal];
    }else{
        [_buttonProvider setTitle:_post.cardname forState:UIControlStateNormal];
    }
    
    
}
@end
