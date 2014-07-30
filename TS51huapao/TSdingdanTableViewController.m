//
//  TSdingdanTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSdingdanTableViewController.h"
#import "TSdanjuxiangqingTableViewController.h"
#import "TSfahuoItemTableViewCell.h"
#import "TSUser.h"
#import "TSdingdanpost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSRebateTableViewCell.h"
#import "TSfandianTableViewController.h"



@interface TSdingdanTableViewController ()

@property (nonatomic, strong)UIView * sectionView;
@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;
@property (nonatomic, strong) NSArray * posts;

@end

@implementation TSdingdanTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = @"销售订单";
    
    self.page = 1;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
//    self.hidesBottomBarWhenPushed = YES;
    
    [self setupRefresh];
    
     if ([_ConditionType isEqualToString:@"SR"]) {
        
        UINib * nib = [UINib nibWithNibName:@"TSRebateTableViewCell" bundle:nil];
        self.tableView.rowHeight = 76;
        
        [self.tableView registerNib:nib forCellReuseIdentifier:@"rebate"];
    }else{
    
    UINib * nib = [UINib nibWithNibName:@"TSfahuoItemTableViewCell" bundle:nil];
    
    self.tableView.rowHeight = 76;
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"fahuo"];
    }
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    

    [dic setObject:@"M" forKey:@"U_type"];

    if (_ConditionType != nil) {
        [dic setObject:_ConditionType forKey:@"ConditionType"];
    }else{
        [dic setObject:@"SO" forKey:@"ConditionType"];
    }
    [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageindex"];
    
    NSURLSessionDataTask * task = [TSdingdanpost globalTimeGetAnVipTradeConditionWithDictionary:dic Block:^(NSArray *posts,NSUInteger maxcount, NSError *error) {
        if (!error) {
            _maxcount=maxcount;
            if (_page>1) {
                _posts=[_posts arrayByAddingObjectsFromArray:posts];
            }else{
                _posts = posts;
            }
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView headerBeginRefreshing];
    // 2.添加上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _page=1;
    [self getData];
}

- (void)footerRereshing
{
    if (_posts.count<_maxcount) {
        _page=_page+1;
        [self getData];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"通知" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [self.tableView footerEndRefreshing];
        [alert show];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return  _posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_ConditionType isEqualToString:@"SR"])
    {
        TSRebateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rebate"];
        
        if (nil == cell) {
            cell = [[TSRebateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rebate"];
        }
        
        cell.dingdanpost = [_posts objectAtIndex:indexPath.row];
        return cell;
        
    }else{

    TSfahuoItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fahuo"];
    if (nil == cell) {
        cell = [[TSfahuoItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fahuo"];
    }
    
    cell.dingdanpost = [self.posts objectAtIndex:indexPath.row];
        
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_ConditionType isEqualToString:@"SR"]) {
        TSfandianTableViewController * viewController = [[TSfandianTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = _ConditionType;
        viewController.userType = @"C";
        viewController.cardnumber = ((TSRebateTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).dingdanpost.CardCode;
        viewController.lastpost = ((TSRebateTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).dingdanpost;
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
    TSdanjuxiangqingTableViewController * viewController = [[TSdanjuxiangqingTableViewController alloc] initWithStyle:UITableViewStylePlain];
    //viewController.danhao = ((TSfahuoItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).danhao.text;
    viewController.conditiontype = _ConditionType;
    viewController.dingdanpost = ((TSfahuoItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).dingdanpost;
    [self.navigationController pushViewController:viewController animated:YES];
    }
}


@end
