//
//  ItemDetail3TableViewCell.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "ItemDetail3TableViewCell.h"
#import "UIButton+Style.h"

@implementation ItemDetail3TableViewCell

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

- (IBAction)buttonStorClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"☆"]) {
        [sender guzhuhouStyle];
    }else{
        [sender guzhuqianStyle];
    }
}

-(void)setPost:(TSItemDetailPost *)post
{
    _post=post;
    
    if ([_post.U_NEU_cuxiao isEqualToString:@""]) {
        _labelSalesPromInfo.text=NSLocalizedString(@"kong", @"");
    }else{
        _labelSalesPromInfo.text=_post.U_NEU_cuxiao;
    }
    
    if (![_post.U_NEU_SaleType isEqualToString:@"直销"]) {
        if (!_post.U_NEU_Rebate.intValue >0) {
            _image1.hidden=YES;
            _image2.hidden=YES;
        }else{
            [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
            _image1.hidden=NO;
            _image2.hidden=YES;
        }
        
    }
    else
    {
        if (!_post.U_NEU_Rebate.intValue >0) {
            [_image1 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
            _image1.hidden=NO;
            _image2.hidden=YES;
        }else{
            [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
            [_image2 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
            _image1.hidden=NO;
            _image2.hidden=NO;
        }
    }
    
    [_buttonStor guzhuqianStyle];
    
}
@end
