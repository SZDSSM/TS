//
//  TSguzhuTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSguzhuTableViewController : UITableViewController

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;
@property (nonatomic, strong) NSArray * posts;


@end
