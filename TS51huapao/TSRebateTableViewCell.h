//
//  TSRebateTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-29.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSdingdanpost.h"

@interface TSRebateTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cardname;
@property (weak, nonatomic) IBOutlet UILabel *rebate;
@property (weak, nonatomic) IBOutlet UILabel *rebateSum;

@property (strong, nonatomic) TSdingdanpost * dingdanpost;





@end
