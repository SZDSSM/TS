//
//  TSkanyangTableViewCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSkanyangTableViewCell.h"
#import "UIButton+Style.h"
#import "UIImageView+AFNetworking.h"

@interface TSkanyangTableViewCell ()

@property(nonatomic,assign) NSInteger iconNumbers;
@property(nonatomic,assign) CGRect nextRect;

@end


@implementation TSkanyangTableViewCell

- (void)awakeFromNib
{
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:240.0/255.0] CGColor];
    [self.shadowView layer].borderWidth = 0.2;
}

- (void)setKanyangpost:(TSItemListPost *)kanyangpost
{

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _kanyangpost = kanyangpost;
    
    _iconNumbers=0;
    
    [self.guzhu yuyueStyle];
    [self.guzhu setTitle:@"取消预约" forState:UIControlStateNormal];
    
    self.date.text = _kanyangpost.StorDateTime;
    self.contectperson.text = _kanyangpost.vipname;
    self.phoneNumber.text = _kanyangpost.Vipcode;
    self.itemname.text = _kanyangpost.ItemName;
    self.spec.text = [NSString stringWithFormat:@"规格:%@\t含量:%@",_kanyangpost.Spec,_kanyangpost.U_Neu_Content];
    self.price.text = _kanyangpost.Price;
    self.cardname.text=_kanyangpost.cardname;
    if (![_kanyangpost.IsRebate isEqualToString:@"Y"]) {
        if (![_kanyangpost.IsOTO isEqualToString:@"Y"]) {
            if (![_kanyangpost.UMTVURL hasPrefix:@"http"]) {
                _image1.hidden=YES;
                _image2.hidden=YES;
                _image3.hidden=YES;
            }else{
                [_image1 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                _image1.hidden=NO;
                _image2.hidden=YES;
                _image3.hidden=YES;
            }
        }else{
            if (![_kanyangpost.UMTVURL hasPrefix:@"http"]) {
                [_image1 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
                _image1.hidden=NO;
                _image2.hidden=YES;
                _image3.hidden=YES;
            }else{
                [_image1 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
                [_image2 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                _image1.hidden=NO;
                _image2.hidden=NO;
                _image3.hidden=YES;
            }
        }
    }else{
        if (![_kanyangpost.IsOTO isEqualToString:@"Y"]) {
            if (![_kanyangpost.UMTVURL hasPrefix:@"http"]) {
                [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                _image1.hidden=NO;
                _image2.hidden=YES;
                _image3.hidden=YES;
            }else{
                [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                [_image2 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                _image1.hidden=NO;
                _image2.hidden=NO;
                _image3.hidden=YES;
            }
        }else{
            if (![_kanyangpost.UMTVURL hasPrefix:@"http"]) {
                [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                [_image2 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
                _image1.hidden=NO;
                _image2.hidden=NO;
                _image3.hidden=YES;
            }else{
                [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                [_image2 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
                [_image3 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                _image1.hidden=NO;
                _image2.hidden=NO;
                _image3.hidden=NO;
            }
        }
    }
    
    [self.itemimage setImageWithURL:[NSURL URLWithString:_kanyangpost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)guanzhu:(UIButton *)sender {
//    if ([sender.titleLabel.text isEqualToString:@"☆"]) {
//        
//    }
    NSLog(@"sdasdasd");
}
@end
