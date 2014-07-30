//
//  CardShuaiXuanTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardShuaiXuanTableViewController : UITableViewController


@property (nonatomic, strong)NSString * yixuan;

-(void)shuaixuanAtTarget:(UIViewController *)target action:(SEL)action;

@end
