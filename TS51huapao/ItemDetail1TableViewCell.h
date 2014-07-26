//
//  ItemDetail1TableViewCell.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemDetail2TableViewCell.h"
#import "ItemDetail3TableViewCell.h"
#import "ItemDetail4TableViewCell.h"
#import "ItemDetail5TableViewCell.h"
#import "ItemDetail6TableViewCell.h"

#import "TSItemDetailPost.h"

@interface ItemDetail1TableViewCell : UITableViewCell

@property(weak,nonatomic)UIViewController *sender;

@property (weak, nonatomic)TSItemDetailPost * post;

@property (weak, nonatomic) IBOutlet UILabel *LaeblItemName;
@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto2;
@property (weak, nonatomic) IBOutlet UIButton *buttonMtv;
- (IBAction)buttonMtvClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelCurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelOldPrice;


@end
