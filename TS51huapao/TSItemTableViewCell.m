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
#import "ItemDetailTableViewController.h"

@interface TSItemTableViewCell ()

@property(nonatomic,assign) NSInteger iconNumbers;
@property(nonatomic,assign) CGRect nextRect;
@end

@implementation TSItemTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    // Initialization code
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:240.0/255.0] CGColor];
    [self.shadowView layer].borderWidth = 0.2;
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
        if (![_post.IsOTO isEqualToString:@"Y"]) {
            if (![_post.UMTVURL hasPrefix:@"http"]) {
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
            if (![_post.UMTVURL hasPrefix:@"http"]) {
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
        if (![_post.IsOTO isEqualToString:@"Y"]) {
            if (![_post.UMTVURL hasPrefix:@"http"]) {
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
            if (![_post.UMTVURL hasPrefix:@"http"]) {
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
    
    
    
    
    if (![_post.IsStroe isEqualToString:@"Y"]) {
        
    }
    [self.itemimage setImageWithURL:[NSURL URLWithString:_post.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
}
- (void)setGetItemPost:(TSGetItemListPost *)getItemPost
{
    _getItemPost = getItemPost;
    _iconNumbers=0;
    //    [self.guanzhu setTintColor:[UIColor redColor]];
    [self.guanzhu guzhuqianStyle];
    
    self.itemname.text = _getItemPost.ItemName;
    self.Spec.text = _getItemPost.Spec;
    self.Price.text = _getItemPost.Price;
    
    
    
    if (![_getItemPost.IsRebate isEqualToString:@"Y"]) {
        if (![_getItemPost.IsOTO isEqualToString:@"Y"]) {
            if (![_getItemPost.UMTVURL hasPrefix:@"http"]) {
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
            if (![_getItemPost.UMTVURL hasPrefix:@"http"]) {
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
        if (![_getItemPost.IsOTO isEqualToString:@"Y"]) {
            if (![_getItemPost.UMTVURL hasPrefix:@"http"]) {
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
            if (![_getItemPost.UMTVURL hasPrefix:@"http"]) {
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
    
    if (![_getItemPost.IsStroe isEqualToString:@"Y"]) {
        
    }
    [self.itemimage setImageWithURL:[NSURL URLWithString:_getItemPost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
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
        if (![_thirdPageFacPost.IsOTO isEqualToString:@"Y"]) {
            if (![_thirdPageFacPost.UMTVURL hasPrefix:@"http"]) {
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
            if (![_thirdPageFacPost.UMTVURL hasPrefix:@"http"]) {
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
        if (![_thirdPageFacPost.IsOTO isEqualToString:@"Y"]) {
            if (![_thirdPageFacPost.UMTVURL hasPrefix:@"http"]) {
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
            if (![_thirdPageFacPost.UMTVURL hasPrefix:@"http"]) {
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

-(void)pushtoItemDetailView
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailTableViewController *itemdetail = [board instantiateViewControllerWithIdentifier:@"tsItemdetail"];
    if (_post.itemCode!=nil) {
        itemdetail.itemcode=_post.itemCode;
    }else if(_thirdPageFacPost!=nil)
    {
        itemdetail.itemcode=_thirdPageFacPost.ItemCode;
    }else if (_getItemPost!=nil){
        itemdetail.itemcode=_getItemPost.itemCode;
    }
    [_sender.navigationController pushViewController:itemdetail animated:YES];
}
@end
