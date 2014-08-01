//
//  TShuiyuanguanliTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.


#import "TShuiyuanguanliTableViewController.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TShuiyuanguanlipost.h"
#import "TShuiyuanguanliTableViewCell.h"

@interface TShuiyuanguanliTableViewController ()

@property (nonatomic, strong) UIView * sectionview;
@property (nonatomic, strong) NSArray * reloadArr1;
@property (nonatomic, strong) NSArray * reloadArr2;
@property (nonatomic) NSUInteger  now;
@property (nonatomic) NSUInteger lastTap;
@property (nonatomic) NSUInteger nowTap;

@end

@implementation TShuiyuanguanliTableViewController

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
    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    self.now = 1;
    
    self.title = @"会员管理";
    
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 10)]];

    
    _reloadArr1 = [[NSMutableArray alloc]init];
    _reloadArr2 = [[NSMutableArray alloc]init];

    [self setupRefresh];
    [self initSectionView];
    
    _lastTap = _nowTap = 100;

    UINib * nib = [UINib nibWithNibName:@"TShuiyuanguanliTableViewCell" bundle:nil];
    
    self.tableView.rowHeight = 92;
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"huiyuanguanli"];
}

-(void)initSectionView
{
    _sectionview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    _sectionview.backgroundColor = [UIColor whiteColor];
    NSArray * titles = @[@"全部",@"已审核",@"未审核"];
    
    for (int i=0; i<titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*ScreenWidth/3 + 5, 0, ScreenWidth/3-2, 30);
        button.tag = i+100;
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
        [button addTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i) {
            [_sectionview addSubview:[self _initverticalline:CGRectMake((i*ScreenWidth/3)-1, 5,  2, 20)]];
        }else{
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        [_sectionview setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
        [_sectionview addSubview:button];
        
    }
}


- (UIView *)_initverticalline:(CGRect)rect
{
    UIView * vl = [[UIView alloc]initWithFrame:rect];
    vl.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0];
    return vl;
}

- (void)reload:(UIButton *)button
{
    
    for (int i = 0 ; i < 3; i++) {
        
        if (button.tag == i+100 )
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        else
            [(UIButton *)[self.view viewWithTag:i+100] setTitleColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    
    switch (button.tag) {
        case 100:
            self.now = 1;
            
            break;
        case 101:
            self.now = 2;

            break;
        case 102:
            self.now = 3;
            
            break;
            
        default:
            break;
            
    }
    _nowTap = button.tag;
    if (_lastTap != _nowTap) {
        [self.tableView reloadData];
        _lastTap = _nowTap;
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
    NSURLSessionDataTask * task = [TShuiyuanguanlipost globalTimeGetVipListWithDictionary:dic Block:^(NSArray *posts, NSError *error) {
        if (!error) {
            
            _posts = [posts mutableCopy];
            
            NSPredicate *pre1 = [NSPredicate predicateWithFormat:@"status='已审核'"];
            _reloadArr1 = [_posts filteredArrayUsingPredicate: pre1];
            NSPredicate *pre2 = [NSPredicate predicateWithFormat:@"status!='已审核'"];
            _reloadArr2 = [_posts filteredArrayUsingPredicate: pre2];
            
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else
        return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _sectionview;
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
    if (self.now == 1) {
        return [_posts count];
    }else if (self.now == 2){
        return [_reloadArr1 count];
    }else if (self.now == 3){
        return [_reloadArr2 count];
    }
    return [_posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TShuiyuanguanliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"huiyuanguanli"];
    
    if (nil == cell) {
        cell = [[TShuiyuanguanliTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"huiyuanguanli"];
    }
    
    if (self.now == 1) {
        cell.huiyuanpost = [_posts objectAtIndex:indexPath.row];
        cell.guanbi.hidden = YES;
    }else if (self.now == 2){
        cell.huiyuanpost = [_reloadArr1 objectAtIndex:indexPath.row];
        cell.guanbi.hidden = YES;
    }else{
        cell.huiyuanpost = [_reloadArr2 objectAtIndex:indexPath.row];
        if ([cell.huiyuanpost.U_type isEqualToString:@"拒绝"]) {
            cell.guanbi.hidden = YES;
        }else{
        cell.guanbi.hidden = NO;
        cell.guanbi.tag = 200+indexPath.row;

        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.guanbi addTarget:self action:@selector(guanbi:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)guanbi:(UIButton *)sender
{
    NSIndexPath * path = [NSIndexPath indexPathForRow:sender.tag-200 inSection:0];
    TShuiyuanguanliTableViewCell * cell = (TShuiyuanguanliTableViewCell *)[self.tableView cellForRowAtIndexPath:path];
//    [_posts removeObject: cell.huiyuanpost];
    cell.huiyuanpost.U_type = @"拒绝";
    
    [self.tableView reloadData];
}



@end
