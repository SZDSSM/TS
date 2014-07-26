//
//  TSForthViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-9.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "myHttpXieyi.h"

@interface TSForthViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
//@property (nonatomic, retain)NSArray* titles;
@property (nonatomic, retain)UIView * topView;
@property (nonatomic, retain)UIView * redLine;
@property (nonatomic, retain)UIImageView * bigimageView;
@property (nonatomic, retain)UITableView * newstableView;
@property(copy,nonatomic)NSDictionary * newsdic;
@property(copy, nonatomic)NSMutableArray *array;


//- (UIView *)createTopViewWithTitles:(NSArray *)titles;
//- (UITableViewCell *)mycellwithurl:(NSURL *)url;


@end
