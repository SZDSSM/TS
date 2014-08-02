//
//  TSdanjuxiangqingTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSdanjuxiangqingTableViewController.h"
#import "TSdanjuxiangqingTableViewCell.h"
#import "TSdanjuxiangqingpost.h"
#import "TSdingdanpost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"


#import "TSdanjuxiangqingTableViewCell.h"


@interface TSdanjuxiangqingTableViewController ()

@property (nonatomic, strong)NSArray * posts;
@property (nonatomic, strong)UIView * myView;

@end

@implementation TSdanjuxiangqingTableViewController

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
    
    self.title = @"单据详情";
        
    _danhao = _dingdanpost.DocEntry;
    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    if (![_conditiontype isEqualToString:@"SR"]) {
        [self _initmyView];
        
        [self.tableView setTableHeaderView:_myView];
    }
    
    
    [self.tableView setTableFooterView:[self _initfooterView]];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]];
    
    [self setupRefresh];
    
    UINib * nib = [UINib nibWithNibName:@"TSdanjuxiangqingTableViewCell" bundle:nil];
    
    self.tableView.rowHeight = 88;
    
        [self.tableView registerNib:nib forCellReuseIdentifier:@"reuse"];

}

- (void)_initmyView
{
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, ScreenWidth/2, 25)];
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 + 20, 10, ScreenWidth/2-30, 25)];
    UILabel * label5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, ScreenWidth/2, 25)];
    UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 + 20, 35, ScreenWidth/2-30, 25)];
    UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, ScreenWidth/2, 25)];
    UILabel * label6 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2 + 20, 60, ScreenWidth/2-30, 25)];
    UILabel * linelabel = [[UILabel alloc] init];
    
    label1.text = [NSString stringWithFormat:@"日期:%@",_dingdanpost.DocDate];
    label2.text = [NSString stringWithFormat:@"单号:%@",_dingdanpost.DocEntry];
    label3.text = [NSString stringWithFormat:@"状态:%@",_dingdanpost.DocStatus];
    label4.text = [NSString stringWithFormat:@"数量:%@ 箱",_dingdanpost.Quantity];
    label5.text = [NSString stringWithFormat:@"未清数量:%@ 箱",_dingdanpost.OpenQty];
    label6.text = [NSString stringWithFormat:@"金额:¥%@",_dingdanpost.DocTotal];
    linelabel.text = @"------------------------------------------------------------------------------------------------------------------------------------------------------";
    
    label1.textColor = [UIColor lightGrayColor];
    label2.textColor = [UIColor lightGrayColor];
    label3.textColor = [UIColor lightGrayColor];
    label4.textColor = [UIColor lightGrayColor];
    label5.textColor = [UIColor lightGrayColor];
    label6.textColor = [UIColor lightGrayColor];
    linelabel.textColor = [UIColor lightGrayColor];
    
    label5.adjustsFontSizeToFitWidth = YES;
    label4.adjustsFontSizeToFitWidth = YES;
    label6.adjustsFontSizeToFitWidth = YES;
    
    label1.font = [UIFont systemFontOfSize:15.0];
    label2.font = [UIFont systemFontOfSize:15.0];
    label3.font = [UIFont systemFontOfSize:15.0];
    label4.font = [UIFont systemFontOfSize:15.0];
    label5.font = [UIFont systemFontOfSize:15.0];
    label6.font = [UIFont systemFontOfSize:15.0];
    
    if ([_conditiontype isEqualToString:@"SO"]||[_conditiontype isEqualToString:@"PD"]||
        [_conditiontype isEqualToString:@"SD"])
    {
        _myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 95)];
        [linelabel setFrame:CGRectMake(10, 90, ScreenWidth, 1)];
    }
    if ([_conditiontype isEqualToString:@"PO"])
    {
        _myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
        UILabel * label7 = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, ScreenWidth/2-30, 25)];
        label7.textColor = [UIColor lightGrayColor];
        label7.text = [NSString stringWithFormat:@"事务类型:%@",_dingdanpost.U_NEU_DocTpe];
        label7.font = [UIFont systemFontOfSize:15.0];
        [_myView addSubview:label7];
        [linelabel setFrame:CGRectMake(10, 115, ScreenWidth, 1)];
    }
   
    [_myView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]];
    
    [_myView addSubview:label1];
    [_myView addSubview:label2];
    [_myView addSubview:label3];
    [_myView addSubview:label4];
    [_myView addSubview:label5];
    [_myView addSubview:label6];
    [_myView addSubview:linelabel];
}

- (UIView *)_initfooterView
{
    if ([_conditiontype isEqualToString:@"SD"]) {
        
         UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        [view setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]];
        
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, ScreenWidth/2, 25)];
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, ScreenWidth/2, 25)];
        UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, ScreenWidth/2, 25)];
        UILabel * linelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth, 1)];
        
        label1.textColor = [UIColor lightGrayColor];
        label2.textColor = [UIColor lightGrayColor];
        label3.textColor = [UIColor lightGrayColor];
        linelabel.textColor = [UIColor lightGrayColor];

        
        label1.font = [UIFont systemFontOfSize:15.0];
        label2.font = [UIFont systemFontOfSize:15.0];
        label3.font = [UIFont systemFontOfSize:15.0];
        
        label1.text = [NSString stringWithFormat:@"司机:%@",_dingdanpost.U_NEU_drvr];
        label2.text = [NSString stringWithFormat:@"手机号码:%@",_dingdanpost.U_NEU_MbTel];
        label3.text = [NSString stringWithFormat:@"车牌号码:%@",_dingdanpost.U_NEU_Urgency];
        linelabel.text = @"------------------------------------------------------------------------------------------------------------------------------------------";
        
        [view addSubview:label1];
        [view addSubview:label2];
        [view addSubview:label3];
        [view addSubview:linelabel];
        
        return view;
        
    }else{
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
        
        return view;

    }
}

/*
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView headerBeginRefreshing];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self getData];
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    if ( _danhao!=nil) {
        [dic setObject:_danhao forKey:@"DocEntry"];
    }else{
        [dic setObject:@"249" forKey:@"DocEntry"];
    }
    if (_conditiontype != nil) {
        [dic setObject:_conditiontype forKey:@"ConditionType"];
    }else{
        [dic setObject:@"SO" forKey:@"ConditionType"];
    }
   
    NSURLSessionDataTask * task = [TSdanjuxiangqingpost globalTimeGetRecommendInfoWithDictionary:dic Block:^(NSArray *posts, NSError *error) {
        if (!error) {

            _posts = posts;
            
            [self.tableView reloadData];
        }
        [self.tableView headerEndRefreshing];
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
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
    return [_posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSdanjuxiangqingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (nil == cell) {
        cell = [[TSdanjuxiangqingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    
    cell.danjuxiangqingpost = [_posts objectAtIndex:indexPath.row];
    cell.sender=self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        TSdanjuxiangqingTableViewCell *cell=(TSdanjuxiangqingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell pushtoItemDetailView];
}

@end
