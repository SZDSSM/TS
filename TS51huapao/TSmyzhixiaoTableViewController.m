//
//  TSmyzhixiaoTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-24.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSmyzhixiaoTableViewController.h"
#import "TSItemTableViewCell.h"
#import "TSGetItemListPost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSUser.h"


@interface TSmyzhixiaoTableViewController ()

@end

@implementation TSmyzhixiaoTableViewController

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
    [self setupRefresh];
    
    TSUser * user = [TSUser sharedUser];
    
    _vipCode = user.vipcode;
    _itemType = @"Z";
    
    self.title = @"直销产品";
    
    
    UINib * nib = [UINib nibWithNibName:@"TSItemTableViewCell" bundle:nil];
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
//    if ( _itemname!=nil) {
//        [dic setObject: _itemname forKey:@"itemname"];
//        NSLog(@"url%@",_itemname);
//    }
    if (_itemType != nil) {
        [dic setObject:_itemType forKey:@"itemtype"];
    }
//    if (_sortType != nil) {
//        [dic setObject:_sortType forKey:@"sortType"];
//    }
    if (_vipCode != nil) {
        [dic setObject:_vipCode forKey:@"vipcode"];
    }
//    if (_priceRange != nil) {
//        [dic setObject:_priceRange forKey:@"priceRange"];
//    }
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    //    cell.itemimage.frame = CGRectMake(0, 0, 30, 30);
    
    return cell;
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSItemTableViewCell *cell=(TSItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell pushtoItemDetailView];
}

@end
