//
//  TSResultViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-17.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchThridTableViewController.h"

@class TSCoLtdpost;

@interface TSResultViewController : UITableViewController<UISearchBarDelegate>

@property (nonatomic, strong)NSArray * array;
@property (nonatomic)NSUInteger page;
@property (nonatomic)NSUInteger maxcount;


@property (nonatomic, copy)NSString * section;
@property (nonatomic, copy)NSString * danweitype;
@property (nonatomic, copy)NSString * searchtxt;
@property (nonatomic, copy)NSString * SalesAear;

@property (nonatomic, strong)NSDictionary * pushDic;
@property (nonatomic, strong)NSArray * posts;

@end
