//
//  TSyixiangdingdanTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSItemListPost.h"

@interface TSyixiangdingdanTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemimage;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *itemname;
@property (weak, nonatomic) IBOutlet UILabel *specContent;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *quantity;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *contectperson;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumeber;
@property (weak, nonatomic) IBOutlet UILabel *kucun;

@property (nonatomic, strong) TSItemListPost * yixiangdingdanpost;

@end
