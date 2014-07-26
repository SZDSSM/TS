//
//  ItemDetail2TableViewCell.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSItemDetailPost.h"

@interface ItemDetail2TableViewCell : UITableViewCell

@property (weak, nonatomic)TSItemDetailPost * post;

@property (weak, nonatomic) IBOutlet UILabel *labelSpec;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@property (weak, nonatomic) IBOutlet UILabel *labelBoxSepc;
@property (weak, nonatomic) IBOutlet UILabel *labelRoughtWeight;
@property (weak, nonatomic) IBOutlet UILabel *labelItemDescr;
@property (weak, nonatomic) IBOutlet UILabel *labelItemExplain;
@property (weak, nonatomic) IBOutlet UIButton *buttonProvider;
- (IBAction)buttonProviderClick:(UIButton *)sender;


@end
