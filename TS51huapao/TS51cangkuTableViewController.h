//
//  TS51cangkuTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-8-1.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TS51cangkuTableViewController : UITableViewController

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;

@property (nonatomic, strong) NSArray * posts;

@end
