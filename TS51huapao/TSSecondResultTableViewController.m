//
//  TSSecondResultTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-19.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSSecondResultTableViewController.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSItemTableViewCell.h"
#import "TSGetItemListPost.h"
#import "NSString+URLEncoding.h"
#import "TSShaiXuanTableViewController.h"
#import "SearchThridTableViewController.h"

@interface TSSecondResultTableViewController ()

@property(nonatomic,strong)UIView *sectionview;


@property(nonatomic,weak)UISearchBar *SearchBar;

@property (strong, nonatomic) SearchThridTableViewController *SearchThridTableViewController;

@end

@implementation TSSecondResultTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initSectionView
{
    _sectionview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    _sectionview.backgroundColor = [UIColor whiteColor];
    NSArray * titles = @[@"综合﹀",@"销量﹀",@"价格﹀"];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSectionView];
    self.page = 1;
    _sortType=@"C";
    
//    UIButton * shaixuanButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
//    [shaixuanButton setTitle:@"筛选" forState:UIControlStateNormal];
//    [shaixuanButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [shaixuanButton addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = shaixuanButton;
    
    
    [self.tableView setTableFooterView:({
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 7)];
        [linelabel setBackgroundColor:[UIColor  colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 23, ScreenWidth-80, 0)];
        NSString * string = @"51花炮云商为仓储产品提供物流、交易保障、质检等服务";
        
        [label setTextColor:[UIColor lightGrayColor]];
        [label setNumberOfLines:0];
        label.font = [UIFont systemFontOfSize:14];
        
        NSMutableAttributedString * attributtedString = [[NSMutableAttributedString alloc] initWithString:string];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:3.0f];
        [attributtedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
        label.attributedText = attributtedString;
        
        [label sizeToFit];
        
        [footView addSubview:label];
        [footView addSubview:linelabel];


        
        footView;
        
    })];
    
    _SearchThridTableViewController=[[SearchThridTableViewController alloc]initWithSearchesKey:@"ItemSearchesKey" SearchPlaceholder:NSLocalizedString(@"itemsearchplaceholder", @"") searchtext:_searchtext rightButtonTitle:@"筛选" target:self action:@selector(SearchButtonClicked:)];
    _SearchBar=_SearchThridTableViewController.searchBar;
    [_SearchThridTableViewController shuaixuanAtTarget:self action:@selector(shaixuan)];
    
    [self setupRefresh];


    
    UINib * nib = [UINib nibWithNibName:@"TSItemTableViewCell" bundle:nil];
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
}


-(void)dealloc
{
    NSLog(@"dealloc::::TSSecondResultViewController");
}

//searchar table 页面回调
-(void)SearchButtonClicked:(NSString *)searchBartxt
{
    _searchtext=searchBartxt;
    [self getData];
}


- (void)shaixuan
{
    TSShaiXuanTableViewController * viewController = [[TSShaiXuanTableViewController alloc]init];
    [viewController shuaixuanAtTarget:self action:@selector(updateWithShuaixuan:)];
    viewController.itemName = self.itemname;
    viewController.yixuan = self.priceRange;
    UINavigationController *shuaixuanNavigation=[[UINavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:shuaixuanNavigation animated:YES completion:nil];
}
//筛选页面 回调
-(void)updateWithShuaixuan:(NSString *)shuaixuanstring 
{
    _page=1;
    _priceRange=shuaixuanstring;
    [self getData];
}
//重新加载数据
- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    if ( _itemname!=nil) {
        [dic setObject: _itemname forKey:@"itemname"];
        NSLog(@"url%@",_itemname);
    }
    if (_searchtext != nil) {
        [dic setObject:_searchtext forKey:@"queryname"];
    }
    if (_itemType != nil) {
        [dic setObject:_itemType forKey:@"itemtype"];
    }
    if (_sortType != nil) {
        [dic setObject:_sortType forKey:@"sortType"];
    }
    if (_vipCode != nil) {
        [dic setObject:_vipCode forKey:@"vipcode"];
    }
    if (_priceRange != nil) {
        [dic setObject:_priceRange forKey:@"priceRange"];
    }
    [dic setObject:[NSString stringWithFormat:@"%u",_page] forKey:@"pageindex"];
    
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
    _searchtext=_SearchBar.text;
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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView footerEndRefreshing];
            [alert show];
        });
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else
        return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _sectionview;
}

- (UIView *)_initverticalline:(CGRect)rect
{
    UIView * vl = [[UIView alloc]initWithFrame:rect];
    vl.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1.0];
    return vl;
}

- (void)reload:(UIButton *)button
{
    static  BOOL isDown = NO;
    static int NowTap = 100;
    static int LastTap = 100;
    
    
    for (int i = 0 ; i < 4; i++) {
        
        if (button.tag == i+100 )
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        else
            [(UIButton *)[self.view viewWithTag:i+100] setTitleColor:[UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }

    switch (button.tag) {
        case 100:
            _sortType = @"C";
            
            break;
        case 101:
            _sortType = @"S";
            
            break;
        case 102:
            
            if (isDown) {
                [button setTitle:@"价格﹀" forState:UIControlStateNormal];
                _sortType = @"PD";
            }else{
                [button setTitle:@"价格︿" forState:UIControlStateNormal];
                _sortType = @"P";
            }
            isDown = !isDown;
            break;
            
            
        default:
            break;
    
    }
    NowTap = button.tag;
    if (button.tag == 102) {
        LastTap = 0;
    }
    if (LastTap != NowTap) {
        _page=1;
        [self getData];
        LastTap = NowTap;
    }
   
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
