//
//  TSItemTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-13.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailTableViewController.h"
#import "TSGetItemListPost.h"

@class TSItemListPost;
@class TSFactorypost;
@interface TSItemTableViewCell : UITableViewCell<TSGuanZhuProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *shadowView;

@property (weak, nonatomic) IBOutlet UILabel *itemname;
@property (weak, nonatomic) IBOutlet UIImageView *itemimage;
@property (weak, nonatomic) IBOutlet UILabel *Spec;
@property (weak, nonatomic) IBOutlet UILabel *Price;

@property (weak, nonatomic) IBOutlet UIButton *guanzhu;
- (IBAction)guanzhu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *order;

@property (weak, nonatomic) TSItemListPost * post;
@property (weak, nonatomic) TSGetItemListPost * getItemPost;

@property (weak, nonatomic) TSFactorypost * thirdPageFacPost;


@property (weak, nonatomic) UIViewController  *sender;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;


-(void)pushtoItemDetailView;

@end
