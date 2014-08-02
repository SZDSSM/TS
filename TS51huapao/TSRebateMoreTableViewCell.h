//
//  TSRebateMoreTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-29.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSdingdanpost.h"
#import "TSfandianTableViewController.h"
@interface TSRebateMoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemimage;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *cardname;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *singlerebate;
@property (weak, nonatomic) IBOutlet UILabel *rebateSum;

@property (strong, nonatomic) TSdingdanpost * dingdanpost;

@property (weak, nonatomic) TSfandianTableViewController  *sender;

-(void)pushtoItemDetailView;

@end
