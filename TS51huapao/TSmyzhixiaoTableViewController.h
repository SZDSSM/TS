//
//  TSmyzhixiaoTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-24.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSmyzhixiaoTableViewController : UITableViewController

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;

//@property (nonatomic,strong) NSString * itemname;
@property (nonatomic, strong) NSString * itemType;
//@property (nonatomic, strong) NSString * sortType;
@property (nonatomic, strong) NSString * vipCode;
//@property (nonatomic, strong) NSString * priceRange;

@property (nonatomic, strong) NSArray * posts;

@end
