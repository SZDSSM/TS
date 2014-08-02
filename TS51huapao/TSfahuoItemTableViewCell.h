//
//  TSfahuoItemTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSdingdanpost.h"

@interface TSfahuoItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *quantity;
@property (weak, nonatomic) IBOutlet UILabel *priceSum;
@property (weak, nonatomic) IBOutlet UILabel *danhao;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (strong, nonatomic) TSdingdanpost * dingdanpost;




@end
