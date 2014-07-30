//
//  TSdanjuxiangqingTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-27.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSdanjuxiangqingpost.h"

@interface TSdanjuxiangqingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemimage;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *itemname;
@property (weak, nonatomic) IBOutlet UILabel *unitprice;
@property (weak, nonatomic) IBOutlet UILabel *quantity;
@property (weak, nonatomic) IBOutlet UILabel *priceSum;
@property (weak, nonatomic) IBOutlet UILabel *openQuantity;

@property (strong, nonatomic) TSdanjuxiangqingpost * danjuxiangqingpost;

@end
