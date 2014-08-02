//
//  TSmyproductTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-8-2.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSmyproductTableViewController.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSmyproductTableViewCell.h"
#import "TSFactorypost.h"
#import "ItemDetailTableViewController.h"
#import "TSUser.h"


@interface TSmyproductTableViewController ()

@end

@implementation TSmyproductTableViewController

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
    
    [self setupRefresh];

    
    UINib * nib = [UINib nibWithNibName:@"TSmyproductTableViewCell" bundle:nil];
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"myproduct"];


}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
   
    
    [dic setObject:[TSUser sharedUser].cardcode forKey:@"CardCode"];
    
    
    [dic setObject:[TSUser sharedUser].vipcode forKey:@"vipcode"];
    
    [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageindex"];
    
    NSURLSessionDataTask * task = [TSFactorypost globalTimeGetRecommendInfoWithDictionary:dic Block:^(NSArray *posts,NSUInteger maxcount, NSError *error) {
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
    
    //[UIActivityIndicatorView set ]
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
    TSmyproductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myproduct"];
    if (nil == cell) {
        cell = [[TSmyproductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myproduct"];
    }
    
    cell.post = [self.posts objectAtIndex:indexPath.row];
    cell.sender=self;
    
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSmyproductTableViewCell *cell=(TSmyproductTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell pushtoItemDetailView];
    
}


@end
