//
//  TSKanYangTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSKanYangTableViewController : UITableViewController

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;
@property (nonatomic, strong) NSMutableArray * posts;
//@property (nonatomic, strong) NSString * vipcode;

-(void)removeFormPosts:(id)sender;
@end
