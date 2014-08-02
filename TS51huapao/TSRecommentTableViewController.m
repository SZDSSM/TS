//
//  TSRecommentTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSRecommentTableViewController.h"
#import "TSItemTableViewCell.h"
#import "TSItemListPost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "ItemSearchTableViewController.h"
#import "TSSecondResultTableViewController.h"


@interface TSRecommentTableViewController ()

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger maxcount;

@property (strong, nonatomic) NSString * recomment;
@property (strong, nonatomic) NSArray * posts;


@property(strong,nonatomic)ItemSearchTableViewController *searchbarControl;
@end

@implementation TSRecommentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRecomment:(NSString *)Recomment
{
    self = [super init];
    
    self.recomment = Recomment;
    
    [self setHidesBottomBarWhenPushed:YES];
    
    return self;
}
- (void)dealloc
{
//    NSLog(@"deallpc::::");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)]];
    [self setupRefresh];
    
    UINib * nib = [UINib nibWithNibName:@"TSItemTableViewCell" bundle:nil];
    self.tableView.rowHeight = 65;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
    
    self.title=_recomment;
    
    self.tableView.rowHeight = 100;
    
    
    _searchbarControl=[[ItemSearchTableViewController alloc]initWithSearchesKey:@"ItemSearchesKey" SearchPlaceholder:NSLocalizedString(@"itemsearchplaceholder", @"") target:self action:@selector(searchButtonClick:)];
    
}

-(void)searchButtonClick:(NSString *)searchText
{
    TSSecondResultTableViewController * viewController = [[TSSecondResultTableViewController alloc] init];
    viewController.searchtext = searchText;
    viewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    
    if (_recomment != nil) {
        [dic setObject:_recomment forKey:@"queryname"];
    }
    [dic setObject:@"C" forKey:@"sortType"];
    
    [dic setObject:[TSUser sharedUser].vipcode forKey:@"vipcode"];

    [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageindex"];
    
    NSURLSessionDataTask * task = [TSItemListPost globalTimeGetRecommendInfoWithDictionary:dic Block:^(NSArray *posts,NSUInteger maxcount, NSError *error) {
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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSItemTableViewCell *cell=(TSItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell pushtoItemDetailView];
    
}

@end
