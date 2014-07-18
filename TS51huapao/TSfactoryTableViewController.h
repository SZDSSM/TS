//
//  TSfactoryTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-18.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSCoLtdpost;

@interface TSfactoryTableViewController : UITableViewController

@property (nonatomic, strong) NSArray * array;
@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;
@property (nonatomic, strong) NSString * CardCode;


@property (nonatomic, strong) TSCoLtdpost * Coltdpost;

@property (nonatomic, strong) NSDictionary * pushDic;
@property (nonatomic, strong) NSArray * posts;

@property (nonatomic) BOOL scrollupordown;

@end
