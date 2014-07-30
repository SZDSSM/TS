//
//  TSdanjuxiangqingTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSdingdanpost;

@interface TSdanjuxiangqingTableViewController : UITableViewController

@property (nonatomic, strong)TSdingdanpost * dingdanpost;
@property (nonatomic, strong)NSString * danhao;
@property (nonatomic, strong)NSString * conditiontype;



@end
