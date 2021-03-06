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

#import "TSAppDoNetAPIClient.h"
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

-(void)setPriceTextWith:(NSString *)price costPrice:(NSString *)costPrice oldPrice:(NSString *)oldPrice stock:(NSString *)stock
{
    if ([TSUser sharedUser].USERTYPE==TSVender) {
        _price.text=[stock stringByAppendingString:@"箱"];
    }else{
        NSString *cp=[[NSString alloc]init];
        if([TSUser sharedUser].USERTYPE==TSUnionClient && costPrice.floatValue>1){
            cp=[@"¥" stringByAppendingString:costPrice];
        }else{
            cp=[@"¥" stringByAppendingString:price];
        }
        NSUInteger len=cp.length;
        if (costPrice.floatValue>1&&[TSUser sharedUser].USERTYPE==TSManager) {
            cp=[cp stringByAppendingString:@"("];
            cp=[cp stringByAppendingString:costPrice];
            cp=[cp stringByAppendingString:@")"];
            len=len+costPrice.length+2;
        }
        cp=[cp stringByAppendingString:@"元/箱"];
        if (stock.floatValue>0) {
            cp=[cp stringByAppendingString:@"  "];
            cp=[cp stringByAppendingString:stock];
            cp=[cp stringByAppendingString:@"箱"];
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:cp];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,len)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0,len)];
        _price.attributedText=str;
    }
}
-(void)setImageViewWithIsOTO:(NSString *)IsOTO IsRebate:(NSString *)IsRebate MTVURL:(NSString *)MTVURL JIAN:(BOOL)IsJian{
    if ([TSUser sharedUser].USERTYPE==TSCommonClient) {
        if (![IsRebate isEqualToString:@"Y"]) {
            if (!IsJian) {
                if (![MTVURL hasPrefix:@"http"]) {
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
                if (![MTVURL hasPrefix:@"http"]) {
                    [_image1 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                    _image1.hidden=NO;
                    _image2.hidden=YES;
                    _image3.hidden=YES;
                }else{
                    [_image1 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                    [_image2 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                    _image1.hidden=NO;
                    _image2.hidden=NO;
                    _image3.hidden=YES;
                }
            }
        }else{
            if (!IsJian) {
                if (![MTVURL hasPrefix:@"http"]) {
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
                if (![MTVURL hasPrefix:@"http"]) {
                    [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                    [_image2 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                    _image1.hidden=NO;
                    _image2.hidden=NO;
                    _image3.hidden=YES;
                }else{
                    [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                    [_image2 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                    [_image3 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                    _image1.hidden=NO;
                    _image2.hidden=NO;
                    _image3.hidden=NO;
                }
            }
        }
    }
    else if ([TSUser sharedUser].USERTYPE==TSVender) {
        if (![MTVURL hasPrefix:@"http"]) {
            _image1.hidden=YES;
            _image2.hidden=YES;
            _image3.hidden=YES;
        }else{
            [_image1 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
            _image1.hidden=NO;
            _image2.hidden=YES;
            _image3.hidden=YES;
        }
    }
    else  if ([TSUser sharedUser].USERTYPE==TSManager ||[TSUser sharedUser].USERTYPE==TSUnionClient){
        if (![IsOTO isEqualToString:@"Y"]) {
            if (![IsRebate isEqualToString:@"Y"]) {
                if (!IsJian) {
                    if (![MTVURL hasPrefix:@"http"]) {
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
                    if (![MTVURL hasPrefix:@"http"]) {
                        [_image1 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                        _image1.hidden=NO;
                        _image2.hidden=YES;
                        _image3.hidden=YES;
                    }else{
                        [_image1 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                        [_image2 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                        _image1.hidden=NO;
                        _image2.hidden=NO;
                        _image3.hidden=YES;
                    }
                }
            }else{
                if (!IsJian) {
                    if (![MTVURL hasPrefix:@"http"]) {
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
                    if (![MTVURL hasPrefix:@"http"]) {
                        [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                        [_image2 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                        _image1.hidden=NO;
                        _image2.hidden=NO;
                        _image3.hidden=YES;
                    }else{
                        [_image1 setImage:[UIImage imageNamed:@"ic_fanlianniu"]];
                        [_image2 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                        [_image3 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                        _image1.hidden=NO;
                        _image2.hidden=NO;
                        _image3.hidden=NO;
                    }
                }
            }
        }else{
            if (!IsJian) {
                if (![MTVURL hasPrefix:@"http"]) {
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
            }else{
                if (![MTVURL hasPrefix:@"http"]) {
                    [_image1 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
                    [_image2 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                    _image1.hidden=NO;
                    _image2.hidden=NO;
                    _image3.hidden=YES;
                }else{
                    [_image1 setImage:[UIImage imageNamed:@"ic_zhijianganniu"]];
                    [_image2 setImage:[UIImage imageNamed:@"ic_launcher_jjph"]];
                    [_image3 setImage:[UIImage imageNamed:@"ic_bofanganniu"]];
                    _image1.hidden=NO;
                    _image2.hidden=NO;
                    _image3.hidden=NO;
                }
            }
        }
    }
}


- (void)setKanyangpost:(TSItemListPost *)kanyangpost
{

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _kanyangpost = kanyangpost;
    
    _iconNumbers=0;
    
    [self.guzhu yuyueStyle];
    if ([TSUser sharedUser].USERTYPE==TSManager) {
        [self.guzhu setTitle:@"关闭预约" forState:UIControlStateNormal];
    }else{
        [self.guzhu setTitle:@"取消看样" forState:UIControlStateNormal];
    }
    
    
    self.date.text = _kanyangpost.StorDateTime;
    self.contectperson.text = _kanyangpost.vipname;
    self.phoneNumber.text = _kanyangpost.Vipcode;
    self.itemname.text = _kanyangpost.ItemName;
    self.spec.text = [NSString stringWithFormat:@"规格:%@\t含量:%@",_kanyangpost.Spec,_kanyangpost.U_Neu_Content];
    //self.price.text = _kanyangpost.Price;
    
    [self setPriceTextWith:kanyangpost.Price costPrice:kanyangpost.costPrice oldPrice:kanyangpost.oldPrice stock:kanyangpost.stocksum];
    [self setImageViewWithIsOTO:kanyangpost.IsOTO IsRebate:kanyangpost.IsRebate MTVURL:kanyangpost.UMTVURL JIAN:kanyangpost.oldPrice.floatValue>kanyangpost.Price.floatValue];
    
    [self.itemimage setImageWithURL:[NSURL URLWithString:_kanyangpost.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)guanzhu:(UIButton *)sender {
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxDelSampleItem.ashx" parameters:@{@"vipcode":_kanyangpost.Vipcode,@"itemcode":_kanyangpost.itemCode} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"关闭预约"
                                      message:@"关闭预约看样成功"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
            [_sender removeFormPosts:_kanyangpost];
        }else if ([rslt isEqualToString:@"false"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"关闭操作失败"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:alertView
                                            repeats:NO];
            [alertView show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:[error localizedDescription]
                                  delegate:nil
                                  cancelButtonTitle:@"关闭"
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

-(void)pushtoItemDetailView
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailTableViewController *itemdetail = [board instantiateViewControllerWithIdentifier:@"tsItemdetail"];
    itemdetail.itemcode=_kanyangpost.itemCode;
    itemdetail.KanYandelegate=self;
    [_sender.navigationController pushViewController:itemdetail animated:YES];
}

#pragma ---TsKanYanProtocol
-(void)KanYanButtonClicked
{
    [_sender removeFormPosts:_kanyangpost];
}
@end
