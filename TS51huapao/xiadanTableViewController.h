//
//  xiadanTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSItemDetailPost.h"



@class ItemDetailTableViewController;

@interface xiadanTableViewController : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>



@property (weak, nonatomic)TSItemDetailPost * post;


@property (weak, nonatomic) IBOutlet UILabel *labelQty;

@property (weak, nonatomic) IBOutlet UILabel *labelYiXiaDan;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UIImageView *photo1;
@property (weak, nonatomic) IBOutlet UILabel *itemname;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *orderQty;
@property (weak, nonatomic) IBOutlet UITextField *qty;
@property (weak, nonatomic) IBOutlet UILabel *stock;
@property (weak, nonatomic) IBOutlet UIButton *xiadan;
- (IBAction)xiadanClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *call;
- (IBAction)callClick:(UIButton *)sender;

-(void)xiadanAtTarget:(UIViewController *)target action:(SEL)action;
-(void)changeInfo:(UIBarButtonItem *)sender;

@end
