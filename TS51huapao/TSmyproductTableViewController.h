//
//  TSmyproductTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-8-2.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSmyproductTableViewController : UITableViewController

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;
@property (nonatomic, strong) NSArray * posts;
@property (nonatomic, strong) NSDictionary * pushDic;

@end
