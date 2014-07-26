//
//  TSShaiXuanTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-21.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSShaiXuanTableViewController : UITableViewController

@property (nonatomic, strong)NSString * itemName;
@property (nonatomic, strong)NSString * yixuan;


-(void)shuaixuanAtTarget:(UIViewController *)target action:(SEL)action;

@end
