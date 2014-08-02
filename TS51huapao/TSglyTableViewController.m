//
//  TSglyTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-25.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//
#import "LoginNavigationController.h"
#import "MJRefresh.h"
#import "TSglyTableViewController.h"
#import "AFNetworking.h"
#import "TSMyInfoTableViewController.h"
#import "TSMyComInfoTableViewController.h"
#import "TSdingdanTableViewController.h"
#import "TSKanYangTableViewController.h"
#import "TSguzhuTableViewController.h"
#import "TSYiXiangDingDanTableViewController.h"
#import "TSAppDoNetAPIClient.h"
#import "TSmyzhixiaoTableViewController.h"
#import "TShuiyuanguanliTableViewController.h"
#import "TS51cangkuTableViewController.h"
#import "TSmyproductTableViewController.h"
#import "TSfandianTableViewController.h"

static NSString*const BaseURLString = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetAnVipTradeCondition.ashx?U_type=M&ConditionType=TO&CardCode=m";

@interface TSglyTableViewController ()

@property (nonatomic, strong)NSArray * placeArray;

@property (nonatomic, strong)NSDictionary * getDic;

@property(nonatomic,strong)NSString *U_type;

@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;

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
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)]];
    self.title = @"我";
    
    [self setupRefresh];
    
    [self tableViewRefreshWithUtypeChange];
    
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.tableView addHeaderWithTarget:self action:@selector(getSumData)];

    [self.tableView headerBeginRefreshing];

}

-(void)tableViewRefreshWithUtypeChange
{
    if ([TSUser sharedUser].USERTYPE==TSManager) {
        _placeArray=@[@"会员管理",@"51仓库",@"直销产品",@"我的关注",@"销售订单",@"采购订单",@"收货单",@"发货单",@"返点清单",@"预约打样",@"意向订单",@"我的消息",@"会员退出"];
        _sectionView=[self ManagerSectionView];
        _U_type=@"M";
    }else if ([TSUser sharedUser].USERTYPE==TSVender) {
        _placeArray=@[@"企业资料",@"个人资料",@"我的关注",@"我的产品库",@"我的订单",@"发货单",@"我的消息",@"会员退出"];
        _sectionView=[self VenderSectionView];
        _U_type=@"S";
    }else if ([TSUser sharedUser].USERTYPE==TSCommonClient) {
        _placeArray=@[@"企业资料",@"个人资料",@"我的关注",@"我的订单",@"收货单/51发货单",@"我的返点",@"预约打样",@"意向订单",@"我的消息",@"会员退出"];
        _sectionView=[self ClientSectionView];
        _U_type=@"C";
    }else if ([TSUser sharedUser].USERTYPE==TSUnionClient) {
        _placeArray=@[@"企业资料",@"个人资料",@"直销产品",@"我的关注",@"我的订单",@"收货单/51发货单",@"我的返点",@"预约打样",@"意向订单",@"我的消息",@"会员退出"];
        _sectionView=[self ClientSectionView];
        _U_type=@"C";
    }else{
        _placeArray=[NSArray array];
    }
    
    [self.tableView setTableHeaderView:_sectionView];
    
    [self getSumData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView addSubview:_sectionView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)getSumData
{
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetAnVipTradeCondition.ashx" parameters:@{@"U_type":_U_type,@"ConditionType":@"TO",@"CardCode":[TSUser sharedUser].cardcode} success:^(NSURLSessionDataTask *task, id responseObject) {
        self.getDic=responseObject;
        if ([_U_type isEqualToString:@"M"]) {
            [self _initManagerXiangXiLabel];
        }else if ([_U_type isEqualToString:@"S"]) {
            [self _initVenderXiangXiLabel];
        }else if ([_U_type isEqualToString:@"C"]) {
            [self _initClientXiangXiLabel];
        }
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [AlertView1 show];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    }];
}

- (UIView *)ManagerSectionView
{
    UIView *sectionview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 45, 45)];
    [headImage setImage:[UIImage imageNamed:@"2.jpg"]];
    headImage.contentMode = UIViewContentModeScaleToFill;
    //    [headImage setBackgroundColor:[UIColor blueColor]];
    
    //cardname
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, ScreenWidth-70, 20)];
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = [TSUser sharedUser].CARD_CardName;
    [nameLabel setBackgroundColor:[UIColor whiteColor]];
    nameLabel.adjustsFontSizeToFitWidth=YES;
    //cantactname
    UILabel * nameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, ScreenWidth-70, 20)];
    [nameLabel2 setTextColor:[UIColor lightGrayColor]];
    nameLabel2.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel2.text = [NSString stringWithFormat:@" (%@)",[TSUser sharedUser].U_name];
    [nameLabel2 setBackgroundColor:[UIColor whiteColor]];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10,75, (ScreenWidth-25)/2, 50)];
    view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-25)/2, 15)];
    biaotilabel.text = @"总发货";
    [biaotilabel setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel setTextColor:[UIColor grayColor]];
    [biaotilabel setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:biaotilabel];
    _label1= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
    _label1.textColor = [UIColor grayColor];
    _label1.font = [UIFont systemFontOfSize:14];
    _label1.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_label1];
    [sectionview addSubview:view];
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(15+(ScreenWidth-25)/2,75, (ScreenWidth-25)/2, 50)];
    view1.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-25)/2, 15)];
    biaotilabel1.text = @"未清";
    [biaotilabel1 setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel1 setTextColor:[UIColor grayColor]];
    [biaotilabel1 setFont:[UIFont systemFontOfSize:14]];
    [view1 addSubview:biaotilabel1];
    _label2= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
    _label2.textColor = [UIColor grayColor];
    _label2.font = [UIFont systemFontOfSize:14];
    _label2.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:_label2];
    [sectionview addSubview:view1];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(10,130, (ScreenWidth-25)/2, 50)];
    view2.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-25)/2, 15)];
    biaotilabel2.text = @"总收货";
    [biaotilabel2 setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel2 setTextColor:[UIColor grayColor]];
    [biaotilabel2 setFont:[UIFont systemFontOfSize:14]];
    [view2 addSubview:biaotilabel2];
    _label3= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
    _label3.textColor = [UIColor grayColor];
    _label3.font = [UIFont systemFontOfSize:14];
    _label3.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:_label3];
    [sectionview addSubview:view2];
    
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(15+(ScreenWidth-25)/2,130, (ScreenWidth-25)/2, 50)];
    view3.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-25)/2, 15)];
    biaotilabel3.text = @"未清";
    [biaotilabel3 setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel3 setTextColor:[UIColor grayColor]];
    [biaotilabel3 setFont:[UIFont systemFontOfSize:14]];
    [view3 addSubview:biaotilabel3];
    _label4= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
    _label4.textColor = [UIColor grayColor];
    _label4.font = [UIFont systemFontOfSize:14];
    _label4.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:_label4];
    [sectionview addSubview:view3];
    
    
    
    UILabel * linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 192, ScreenWidth, 7)];
    [linelabel setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]];
    UILabel * linelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 191, ScreenWidth, 9)];
    [linelabel1 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
    [sectionview addSubview:linelabel1];
    [sectionview addSubview:linelabel];
    [sectionview addSubview:nameLabel];
    [sectionview addSubview:nameLabel2];
    [sectionview addSubview:headImage];
    return sectionview;
}
- (UIView *)VenderSectionView
{
    UIView  *initview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 45, 45)];
    [headImage setImage:[UIImage imageNamed:@"2.jpg"]];
    headImage.contentMode = UIViewContentModeScaleToFill;
    //    [headImage setBackgroundColor:[UIColor blueColor]];
    
    //cardname
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, ScreenWidth-70, 20)];
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = [TSUser sharedUser].CARD_CardName;
    [nameLabel setBackgroundColor:[UIColor whiteColor]];
    nameLabel.adjustsFontSizeToFitWidth=YES;
    //cantactname
    UILabel * nameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, ScreenWidth-70, 20)];
    [nameLabel2 setTextColor:[UIColor lightGrayColor]];
    nameLabel2.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel2.text = [NSString stringWithFormat:@" (%@)",[TSUser sharedUser].U_name];
    [nameLabel2 setBackgroundColor:[UIColor whiteColor]];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10, 75, (ScreenWidth-30)/2, 50)];
    view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-25)/2, 15)];
    biaotilabel.text = @"库存数量";
    [biaotilabel setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel setTextColor:[UIColor grayColor]];
    [biaotilabel setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:biaotilabel];
    _label1= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
    _label1.textColor = [UIColor grayColor];
    _label1.font = [UIFont systemFontOfSize:14];
    _label1.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_label1];
    [initview addSubview:view];
    
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(10+( (ScreenWidth-25)/2 +5), 75, (ScreenWidth-30)/2, 50)];
    view1.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-25)/2, 15)];
    biaotilabel1.text = @"总发货量";
    [biaotilabel1 setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel1 setTextColor:[UIColor grayColor]];
    [biaotilabel1 setFont:[UIFont systemFontOfSize:14]];
    [view1 addSubview:biaotilabel1];
    _label2= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
    _label2.textColor = [UIColor grayColor];
    _label2.font = [UIFont systemFontOfSize:14];
    _label2.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:_label2];
    [initview addSubview:view1];
    
    UILabel * linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 133, ScreenWidth, 7)];
    [linelabel setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]];
    UILabel * linelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 132, ScreenWidth, 9)];
    [linelabel1 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
    [initview addSubview:linelabel1];
    [initview addSubview:linelabel];
    [initview addSubview:nameLabel];
    [initview addSubview:nameLabel2];
    [initview addSubview:headImage];
    return initview;
}
- (UIView *)ClientSectionView
{
    UIView *initview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    UIImageView * headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 45, 45)];
    [headImage setImage:[UIImage imageNamed:@"2.jpg"]];
    headImage.contentMode = UIViewContentModeScaleToFill;
    //    [headImage setBackgroundColor:[UIColor blueColor]];
    
    //cardname
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, ScreenWidth-70, 20)];
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = [TSUser sharedUser].CARD_CardName;
    [nameLabel setBackgroundColor:[UIColor whiteColor]];
    nameLabel.adjustsFontSizeToFitWidth=YES;
    //cantactname
    UILabel * nameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, ScreenWidth-70, 20)];
    [nameLabel2 setTextColor:[UIColor lightGrayColor]];
    nameLabel2.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel2.text = [NSString stringWithFormat:@" (%@)",[TSUser sharedUser].U_name];
    [nameLabel2 setBackgroundColor:[UIColor whiteColor]];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10, 75, (ScreenWidth-30)/3, 50)];
    view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-30)/3, 15)];
    biaotilabel.text = @"总发货";
    [biaotilabel setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel setTextColor:[UIColor grayColor]];
    [biaotilabel setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:biaotilabel];
    _label1= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/3, 15)];
    _label1.textColor = [UIColor grayColor];
    _label1.font = [UIFont systemFontOfSize:14];
    _label1.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_label1];
    [initview addSubview:view];
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(10+( (ScreenWidth-30)/3 +5), 75, (ScreenWidth-30)/3, 50)];
    view1.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-30)/3, 15)];
    biaotilabel1.text = @"总金额";
    [biaotilabel1 setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel1 setTextColor:[UIColor grayColor]];
    [biaotilabel1 setFont:[UIFont systemFontOfSize:14]];
    [view1 addSubview:biaotilabel1];
    _label2= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/3, 15)];
    _label2.textColor = [UIColor grayColor];
    _label2.font = [UIFont systemFontOfSize:14];
    _label2.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:_label2];
    [initview addSubview:view1];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(10+2*( (ScreenWidth-30)/3 +5), 75, (ScreenWidth-30)/3, 50)];
    view2.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    UILabel * biaotilabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (ScreenWidth-30)/3, 15)];
    biaotilabel2.text = @"返点";
    [biaotilabel2 setTextAlignment:NSTextAlignmentCenter];
    [biaotilabel2 setTextColor:[UIColor grayColor]];
    [biaotilabel2 setFont:[UIFont systemFontOfSize:14]];
    [view2 addSubview:biaotilabel2];
    _label3= [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/3, 15)];
    _label3.textColor = [UIColor grayColor];
    _label3.font = [UIFont systemFontOfSize:14];
    _label3.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:_label3];
    [initview addSubview:view2];
    
    UILabel * linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 133, ScreenWidth, 7)];
    [linelabel setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]];
    UILabel * linelabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 132, ScreenWidth, 9)];
    [linelabel1 setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]];
    [initview addSubview:linelabel1];
    [initview addSubview:linelabel];
    [initview addSubview:nameLabel];
    [initview addSubview:nameLabel2];
    [initview addSubview:headImage];
    return initview;
}
- (void)_initManagerXiangXiLabel
{
    _label1.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverPriceSUM"]];
    _label2.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"OpenDeliverPriceSUM"]];
    _label3.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"RecivePriceSUM"]];
    _label4.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"OpenRecivePriceSUM"]];
}
- (void)_initClientXiangXiLabel
{
    _label1.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverQtSUM"]];
    _label2.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverPriceSUM"]];
    NSNumber *rebate=[self.getDic objectForKey:@"ReBatePriceSUM"];
    NSNumber *closedRebate=[self.getDic objectForKey:@"ClosedReBatePriceSUM"];
    
    _label3.text =[NSString stringWithFormat:@"%d",(rebate.intValue-closedRebate.intValue)];
    // [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"ReBatePriceSUM"]];
}
- (void)_initVenderXiangXiLabel
{
    _label1.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"OnHand"]];
    _label2.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverQtSUM"]];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_placeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = [_placeArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"会员管理"]) {
         TShuiyuanguanliTableViewController* viewController = [[TShuiyuanguanliTableViewController alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"企业资料"]) {
        UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TSMyComInfoTableViewController *viewController = [board instantiateViewControllerWithIdentifier:@"TSMyComInfoTableView"];
        [viewController.tableView setTableHeaderView: _sectionView];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"个人资料"]) {
        UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TSMyInfoTableViewController *viewController = [board instantiateViewControllerWithIdentifier:@"MyInfoTableView"];
        [viewController.tableView setTableHeaderView: _sectionView];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"51仓库"]) {
        TS51cangkuTableViewController * viewController = [[TS51cangkuTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.title = @"51仓库";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"直销产品"]) {
        TSmyzhixiaoTableViewController * viewController = [[TSmyzhixiaoTableViewController alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"我的关注"]) {
        TSguzhuTableViewController * viewController = [[TSguzhuTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.title = @"我的关注";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"我的产品库"]) {
        TSmyproductTableViewController * viewController = [[TSmyproductTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.title = @"我的产品库";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"销售订单"] ||([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"我的订单"]&&[_U_type isEqualToString:@"C"])) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"SO";
        viewController.title = @"销售订单";
        viewController.userType=_U_type;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"采购订单"]||([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"我的订单"]&&[_U_type isEqualToString:@"S"])) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"PO";
        viewController.title = @"采购订单";
        viewController.userType=_U_type;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"收货单"]||([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"发货单"]&&[_U_type isEqualToString:@"S"])) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"PD";
        viewController.title = @"收货单";
        viewController.userType=_U_type;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"发货单"]||[[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"收货单/51发货单"]) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"SD";
        viewController.title = @"发货单";
        viewController.userType=_U_type;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"返点清单"]) {
        TSdingdanTableViewController * viewController = [[TSdingdanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType = @"SR";
        viewController.title = @"返点清单";
        viewController.userType=_U_type;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"我的返点"]) {
        TSfandianTableViewController * viewController = [[TSfandianTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.ConditionType =@"SR";
        viewController.userType = @"C";
        viewController.cardnumber =[TSUser sharedUser].cardcode;
        viewController.CardName=[TSUser sharedUser].CARD_CardName;
        viewController.U_RebateSUM =[NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"ClosedReBatePriceSUM"]];
        viewController.Rebate=[NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"ReBatePriceSUM"]];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"预约打样"]) {
        TSKanYangTableViewController * viewController = [[TSKanYangTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.title = @"预约打样";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"意向订单"]) {
        TSYiXiangDingDanTableViewController * viewController = [[TSYiXiangDingDanTableViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.title = @"意向订单";
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"会员退出"]) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"会员退出"
                                  message:@"确认注销当前用户的登入?"
                                  delegate:self
                                  cancelButtonTitle:@"退出"
                                  otherButtonTitles:@"取消", nil];
        [alertView show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma  mark-- 实现UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertView.title isEqual:@"会员退出"]) {
        if (buttonIndex==0) {
            [[TSUser sharedUser] cleanVipInfo];
            UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginNavigationController *loginNavigation=[board instantiateViewControllerWithIdentifier:@"LoginNavigation"];
            
            [loginNavigation addVipInfoRefreshWithCallback:^{
                [self tableViewRefreshWithUtypeChange];
            }];
            
            [self presentViewController:loginNavigation animated:NO completion:nil];
        }
    }
}

@end
