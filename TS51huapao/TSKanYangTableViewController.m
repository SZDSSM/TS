//
//  TSKanYangTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSKanYangTableViewController.h"
#import "TSkanyangTableViewCell.h"
#import "TSItemListPost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
//#import "TSUser.h"

@interface TSKanYangTableViewController ()

//@property (nonatomic, strong)TSUser * user;

@end

@implementation TSKanYangTableViewController

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
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib * nib = [UINib nibWithNibName:@"TSkanyangTableViewCell" bundle:nil];
    self.tableView.rowHeight = 149;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"kanyang"];
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    if ( _vipcode!=nil) {
        [dic setObject:_vipcode forKey:@"vipcode"];
    }else{
        [dic setObject:@"13590166783" forKey:@"vipcode"];
    }
    [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageindex"];
    
    NSURLSessionDataTask * task = [TSItemListPost globalTimeGetKanyangInfoWithDictionary:dic Block:^(NSArray *posts,NSUInteger maxcount, NSError *error) {
        if (!error) {
            _maxcount=maxcount;
            if (_page>1) {
                _posts=[_posts arrayByAddingObjectsFromArray:posts];
            }else{
                _posts = posts;
            }
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
}

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
        //[alert show];
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
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSkanyangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kanyang"];
    if (nil == cell) {
        cell = [[TSkanyangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kanyang"];
    }
    
    cell.kanyangpost = [self.posts objectAtIndex:indexPath.row];
    
    return cell;

}

@end
