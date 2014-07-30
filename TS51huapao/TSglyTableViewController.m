//
//  TSglyTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-25.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSglyTableViewController.h"
#import "AFNetworking.h"
#import "TSMyInfoTableViewController.h"
#import "TSMyComInfoTableViewController.h"
#import "TSdingdanTableViewController.h"
#import "TSKanYangTableViewController.h"
#import "TSguzhuTableViewController.h"
#import "TSYiXiangDingDanTableViewController.h"

static NSString*const BaseURLString = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetAnVipTradeCondition.ashx?U_type=M&ConditionType=TO&CardCode=m";

@interface TSglyTableViewController ()

@property (nonatomic, strong)NSMutableArray * itemArray;
@property (nonatomic, strong)NSDictionary * getDic;


@end

@implementation TSglyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"管理中心";
    
    _itemArray = [@[@"会员管理",@"51仓库",@"我的关注",@"销售订单",@"采购订单",@"收货单",@"发货单",@"返点清单",@"预约打样",@"意向订单",@"我的消息",@"会员退出"]mutableCopy];
    
    [self _initData];
    
    _sectionView=[self _initsectionView];
    [self.tableView setTableHeaderView:_sectionView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView addSubview:_sectionView];
    //    self.tabBarController.tabBar.hidden = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = [_itemArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    
    
    return cell;
}

- (void)_initData
{
    
    NSString * touchurl = BaseURLString;
    NSString *URLTmp1 = [touchurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    touchurl = URLTmp1;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: touchurl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        if (resData != nil) {
            //将获取到的数据JSON解析到数组中
            NSError *error;
            self.getDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error];
            [self _initXiangXiLabel];
            [self.tableView reloadData];
            
            
        }else if(nil == resData){
            UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [AlertView1 show];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [AlertView1 show];
    }];
    [operation start];
    
    
}


- (UIView *)_initsectionView
{
    UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 45, 45)];
    [headImage setImage:[UIImage imageNamed:@"2.jpg"]];
    headImage.contentMode = UIViewContentModeScaleToFill;
    //    [headImage setBackgroundColor:[UIColor blueColor]];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, ScreenWidth-70, 45)];
    nameLabel.numberOfLines = 2;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = @"我要花炮管理平台\n（邓书齐）";
    [nameLabel setBackgroundColor:[UIColor whiteColor]];
    for (int j = 0; j < 2; j ++) {
        for (int i = 0; i < 2; i ++) {
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10+i*( (ScreenWidth-25)/2 +5), 75 + j*55, (ScreenWidth-25)/2, 50)];
            view.tag = 100 - i + 2*j;
            view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
            
            UILabel * biaotilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-25)/2, 15)];
            if (i == 0&& j == 0) {
                biaotilabel.text = @"总发货";
            }else if (i == 1&& j == 0){
                biaotilabel.text = @"未清";
            }else if (i == 0&& j == 1)
            {
                biaotilabel.text = @"总收货";
            }else
            {
                biaotilabel.text = @"未清";
            }
            [biaotilabel setTextAlignment:NSTextAlignmentCenter];
            [biaotilabel setTextColor:[UIColor grayColor]];
            [biaotilabel setFont:[UIFont systemFontOfSize:14]];
            
            [view addSubview:biaotilabel];
            
            
            [sectionview addSubview:view];
        }
    }
    
    UILabel * linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 192, ScreenWidth, 7)];
    [linelabel setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]];
    UILabel * linelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 191, ScreenWidth, 9)];
    [linelabel1 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
    [sectionview addSubview:linelabel1];
    [sectionview addSubview:linelabel];
    [sectionview addSubview:nameLabel];
    [sectionview addSubview:headImage];
    return sectionview;
}

- (void)_initXiangXiLabel
{
    for (int j = 0; j < 2; j++) {
        for (int i = 0; i<2; i++) {
            UILabel * xiangxilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
            if (self.getDic != nil) {
                if (i == 0 && j == 0) {
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverPriceSUM"]];
                }else if (i == 1 && j == 0){
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"OpenDeliverPriceSUM"]];
                }else if (i == 0 && j == 1){
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"RecivePriceSUM"]];
                }else if (i == 1 && j == 1){
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"OpenRecivePriceSUM"]];
                }
                xiangxilabel.textColor = [UIColor grayColor];
                xiangxilabel.font = [UIFont systemFontOfSize:14];
                xiangxilabel.textAlignment = NSTextAlignmentCenter;
                
            }
            [[self.view viewWithTag:100 - i + 2*j] addSubview:xiangxilabel];
            
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"会员管理"]) {
        TSMyInfoTableViewController * viewController = [[TSMyInfoTableViewController alloc] init];
        [viewController.tableView setTableHeaderView: _sectionView];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"企业资料"]) {
        TSMyComInfoTableViewController * viewController = [[TSMyComInfoTableViewController alloc] init];
        [viewController.tableView setTableHeaderView: _sectionView];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"销售订单"]) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"SO";
        viewController.title = @"销售订单";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"采购订单"]) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"PO";
        viewController.title = @"采购订单";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"收货单"]) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"PD";
        viewController.title = @"收货单";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"发货单"]) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"SD";
        viewController.title = @"发货单";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"返点清单"]) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"SR";
        viewController.title = @"返点清单";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"预约打样"]) {
        TSKanYangTableViewController * viewController = [[TSKanYangTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.vipcode = @"ALL";
        viewController.title = @"预约打样";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"我的关注"]) {
        TSguzhuTableViewController * viewController = [[TSguzhuTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.title = @"我的关注";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"意向订单"]) {
        TSYiXiangDingDanTableViewController * viewController = [[TSYiXiangDingDanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.vipcode = @"ALL";
        viewController.title = @"意向订单";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
