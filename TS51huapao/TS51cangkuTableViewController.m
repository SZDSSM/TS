//
//  TS51cangkuTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-8-1.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TS51cangkuTableViewController.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSItemTableViewCell.h"
#import "TSGetItemListPost.h"
#import "TSAppDoNetAPIClient.h"


@interface TS51cangkuTableViewController ()

@property (nonatomic, strong)UIView * sectionView;

@end

@implementation TS51cangkuTableViewController

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
    
    [self getDocSum];
    
    
    
    UINib * nib = [UINib nibWithNibName:@"TSItemTableViewCell" bundle:nil];
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];

   }


-(void)getDocSum
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
    
    [dic setObject:@"M" forKey:@"U_type"];
    
    [dic setObject:@"OH" forKey:@"ConditionType"];
    
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
        
        
            sum1=[responseObject objectForKey:@"qtySum"];
            sum2=[responseObject objectForKey:@"priceSum"];
            label1.text=[NSString stringWithFormat:@"总数量: %@",sum1];
            label2.text=[NSString stringWithFormat:@"总金额: %@",sum2];
       
        _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 45)];
        [_sectionView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
        [_sectionView addSubview:label1];
        [_sectionView addSubview:label2];
        [self setupRefresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self setupRefresh];
    }];
}
//重新加载数据
- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [dic setObject:[TSUser sharedUser].vipcode forKey:@"vipcode"];
    
    [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageindex"];
    
    NSURLSessionDataTask * task = [TSGetItemListPost globalTimeGetRecommendInfoWithDictionary:dic Block:^(NSArray *posts,NSUInteger maxcount, NSError *error) {
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    TSItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (nil == cell) {
        cell = [[TSItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.getItemPost = [self.posts objectAtIndex:indexPath.row];
    cell.sender=self;
    cell.order.hidden = YES;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionView;
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSItemTableViewCell *cell=(TSItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell pushtoItemDetailView];
    
}

@end
