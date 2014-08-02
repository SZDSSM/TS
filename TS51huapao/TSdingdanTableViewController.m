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
#import "TSAppDoNetAPIClient.h"


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
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)]];
//    self.title = @"销售订单";
    
    self.page = 1;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    
//    self.hidesBottomBarWhenPushed = YES;
    
    [self getDocSum];
    
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

-(void)getDocSum
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
    
    [dic setObject:_userType forKey:@"U_type"];
    
    [dic setObject:_ConditionType forKey:@"ConditionType"];
    
    if ([TSUser sharedUser].cardcode!=nil) {
        [dic setObject:[TSUser sharedUser].cardcode forKey:@"CardCode"];
    }
    
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetDocSumInfo.ashx" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSNumber *sum1=[[NSNumber alloc]init];
        NSNumber *sum2=[[NSNumber alloc]init];
        
        UILabel *label1=[[UILabel alloc] init];
        label1.frame=CGRectMake(15, 10, 130, 25);
        label1.backgroundColor=[UIColor clearColor];
        label1.textColor=[UIColor lightGrayColor];
        label1.font=[UIFont boldSystemFontOfSize:15];
        label1.adjustsFontSizeToFitWidth=YES;
        
        UILabel *label2=[[UILabel alloc] init];
        label2.frame=CGRectMake(160, 10, 150, 25);
        label2.backgroundColor=[UIColor clearColor];
        label2.textColor=[UIColor lightGrayColor];
        label2.font=[UIFont boldSystemFontOfSize:15];
        label2.adjustsFontSizeToFitWidth=YES;
        
        if (![_ConditionType isEqualToString:@"SR"]) {
            sum1=[responseObject objectForKey:@"qtySum"];
            sum2=[responseObject objectForKey:@"priceSum"];
            label1.text=[NSString stringWithFormat:@"总数量: %@",sum1];
            label2.text=[NSString stringWithFormat:@"总金额: %@",sum2];
        }else{
            sum1=[responseObject objectForKey:@"RebateSum"];
            sum2=[responseObject objectForKey:@"ClosedRebateSumum"];
            label1.text=[NSString stringWithFormat:@"返点总计: %@",sum1];
            label2.text=[NSString stringWithFormat:@"已返点总计: %@",sum2];
        }
        _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 45)];
        [_sectionView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
        [_sectionView addSubview:label1];
        [_sectionView addSubview:label2];
        [self setupRefresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self setupRefresh];
    }];
}
- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    

    [dic setObject:_userType forKey:@"U_type"];
    
    [dic setObject:_ConditionType forKey:@"ConditionType"];
    
    if ([TSUser sharedUser].cardcode!=nil) {
        [dic setObject:[TSUser sharedUser].cardcode forKey:@"CardCode"];
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
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.添加上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [self.tableView headerBeginRefreshing];
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
        viewController.conditiontype = _ConditionType;
        viewController.dingdanpost = ((TSfahuoItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath]).dingdanpost;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:


@end
