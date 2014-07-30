//
//  ItemDetail3TableViewCell.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSItemDetailPost.h"

@protocol TSGuanZhuProtocol <NSObject>

@optional
-(void)guanZhuButtonClicked:(BOOL) isStore;
@end

@interface ItemDetail3TableViewCell : UITableViewCell


@property (nonatomic, weak) id <TSGuanZhuProtocol> delegate;


@property (weak, nonatomic)TSItemDetailPost * post;

@property (weak, nonatomic) IBOutlet UILabel *labelCellTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSalesPromInfo;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIButton *buttonStor;
- (IBAction)buttonStorClick:(UIButton *)sender;


@end
