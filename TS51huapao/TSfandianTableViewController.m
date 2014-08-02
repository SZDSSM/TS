//
//  TSfandianTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSfandianTableViewController.h"
#import "TSdingdanpost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSRebateMoreTableViewCell.h"

@interface TSfandianTableViewController ()

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;
@property (nonatomic, strong) NSArray * posts;

@end

@implementation TSfandianTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.page = 1;
    
    self.title = @"返点详情";
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    //    self.hidesBottomBarWhenPushed = YES;
    
    [self.tableView setTableHeaderView:[self _initheaderView]];
    
    [self setupRefresh];
    
    UINib * nib = [UINib nibWithNibName:@"TSRebateMoreTableViewCell" bundle:nil];
    self.tableView.rowHeight = 88;
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"rebatemore"];
    
}

- (UIView *)_initheaderView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [view setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, ScreenWidth-40, 25)];
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, ScreenWidth-40, 25)];
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 25)];
    UILabel * linelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 95, ScreenWidth, 1)];
    
    label1.textColor = [UIColor lightGrayColor];
    label2.textColor = [UIColor lightGrayColor];
    label3.textColor = [UIColor lightGrayColor];
    linelabel.textColor = [UIColor lightGrayColor];
    
    
    label1.font = [UIFont systemFontOfSize:15.0];
    label2.font = [UIFont systemFontOfSize:15.0];
    label3.font = [UIFont systemFontOfSize:15.0];

    label1.adjustsFontSizeToFitWidth = YES;
    label2.adjustsFontSizeToFitWidth = YES;
    label3.adjustsFontSizeToFitWidth = YES;

    if (_lastpost!=nil) {
        _CardName=_lastpost.CardName;
        _U_RebateSUM=_lastpost.U_RebateSUM;
        _Rebate=_lastpost.Rebate;
    }
    label1.text = [NSString stringWithFormat:@"公司名称:  %@",_CardName];
    label2.text = [NSString stringWithFormat:@"已返点总计:  ¥%@",_U_RebateSUM];
    label3.text = [NSString stringWithFormat:@"返点总计:  ¥%@",_Rebate];
    
    linelabel.text = @"------------------------------------------------------------------------------------------------------------------------------------------";
    
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [view addSubview:linelabel];
    
    return view;
    
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    if (_userType!=nil) {
        [dic setObject:_userType forKey:@"U_type"];
    }else{
        [dic setObject:@"M" forKey:@"U_type"];
    }
    if (_ConditionType != nil) {
        [dic setObject:_ConditionType forKey:@"ConditionType"];
    }else{
        [dic setObject:@"SO" forKey:@"ConditionType"];
    }
    if (_cardnumber != nil) {
        [dic setObject:_cardnumber forKey:@"CardCode"];
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
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    TSRebateMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rebatemore"];
    
    if (nil == cell) {
        cell = [[TSRebateMoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rebatemore"];
    }
    
    cell.dingdanpost = [_posts objectAtIndex:indexPath.row];
    cell.sender=self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSRebateMoreTableViewCell *cell=(TSRebateMoreTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell pushtoItemDetailView];
}

@end
