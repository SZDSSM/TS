//
//  TSMyFirstTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSMyFirstTableViewController.h"
#import "AFNetworking.h"
#import "TSmyzhixiaoTableViewController.h"
#import "TSMyInfoTableViewController.h"
#import "TSMyComInfoTableViewController.h"

static NSString*const BaseURLString = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetAnVipTradeCondition.ashx?U_type=C&ConditionType=TO&CardCode=c0030";

@interface TSMyFirstTableViewController ()

@property (nonatomic, strong)UIView * sectionView;
@property (nonatomic, strong)NSMutableArray * itemArray;
@property (nonatomic, strong)NSDictionary * getDic;


@end

@implementation TSMyFirstTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView addSubview:_sectionView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"管理中心";
    
    _itemArray = [@[@"企业资料",@"个人资料",@"我的产品库",@"直销产品",@"我的订单",@"收获单／51发货单",@"我的返点",@"产品关注",@"我的消息",@"会员退出"]mutableCopy];
    [self _initData];
    [self _initsectionView];
    [self.tableView setTableHeaderView:_sectionView];
    
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


- (void)_initsectionView
{
    _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 45, 45)];
    [headImage setImage:[UIImage imageNamed:@"2.jpg"]];
    headImage.contentMode = UIViewContentModeScaleToFill;
    //    [headImage setBackgroundColor:[UIColor blueColor]];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, ScreenWidth-70, 45)];
    nameLabel.numberOfLines = 2;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = @"河南省开封县祥符烟花爆竹经营公司（张守礼）";
    [nameLabel setBackgroundColor:[UIColor whiteColor]];
    
    for (int i = 0; i < 3; i ++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10+i*( (ScreenWidth-30)/3 +5), 75, (ScreenWidth-30)/3, 50)];
        view.tag = 100 + i;
        view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        
        UILabel * biaotilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-30)/3, 15)];
        if (i == 0) {
            biaotilabel.text = @"总发货";
        }else if (i == 1){
            biaotilabel.text = @"总金额";
        }else if (i == 2){
            biaotilabel.text = @"返点";
        }
        [biaotilabel setTextAlignment:NSTextAlignmentCenter];
        [biaotilabel setTextColor:[UIColor grayColor]];
        [biaotilabel setFont:[UIFont systemFontOfSize:14]];
        
        [view addSubview:biaotilabel];
        
        
        [_sectionView addSubview:view];
    }
    UILabel * linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 133, ScreenWidth, 7)];
    [linelabel setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]];
    UILabel * linelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 132, ScreenWidth, 9)];
    [linelabel1 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
    [_sectionView addSubview:linelabel1];
    [_sectionView addSubview:linelabel];
    [_sectionView addSubview:nameLabel];
    [_sectionView addSubview:headImage];
    
}

- (void)_initXiangXiLabel
{
    
    for (int i = 0; i<3; i++) {
        UILabel * xiangxilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-30)/3, 15)];
        if (self.getDic != nil) {
            if (i == 0) {
                xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverQtSUM"]];
            }else if (i == 1){
                xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverPriceSUM"]];
            }else if (i == 2){
                xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"ReBatePriceSUM"]];
            }
            xiangxilabel.textColor = [UIColor grayColor];
            xiangxilabel.font = [UIFont systemFontOfSize:14];
            xiangxilabel.textAlignment = NSTextAlignmentCenter;
            
        }
        [[self.view viewWithTag:100+i] addSubview:xiangxilabel];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"直销产品"]) {
        TSmyzhixiaoTableViewController * viewController = [[TSmyzhixiaoTableViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"个人资料"]) {
        TSMyInfoTableViewController * viewController = [[TSMyInfoTableViewController alloc] init];
        [viewController.tableView setTableHeaderView: _sectionView];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"企业资料"]) {
        TSMyComInfoTableViewController * viewController = [[TSMyComInfoTableViewController alloc] init];
        [viewController.tableView setTableHeaderView: _sectionView];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
