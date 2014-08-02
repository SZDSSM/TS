//
//  TSfandianTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSdingdanpost;

@interface TSfandianTableViewController : UITableViewController

@property (nonatomic, strong)NSString * userType;
@property (nonatomic, strong)NSString * ConditionType;
@property (nonatomic, strong)NSString * cardnumber;
@property (nonatomic, strong)TSdingdanpost * lastpost;

@property (nonatomic, strong)NSString * CardName;
@property (nonatomic, strong)NSString * U_RebateSUM;
@property (nonatomic, strong)NSString * Rebate;


@end
