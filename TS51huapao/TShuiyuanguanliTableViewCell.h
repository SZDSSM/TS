//
//  TShuiyuanguanliTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TShuiyuanguanlipost.h"

@interface TShuiyuanguanliTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *cardName;
@property (weak, nonatomic) IBOutlet UILabel *contectPerson;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIButton *guanbi;
- (IBAction)gubi:(id)sender;

@property (strong, nonatomic) TShuiyuanguanlipost * huiyuanpost;

@end
