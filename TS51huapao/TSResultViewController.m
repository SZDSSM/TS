//
//  TSResultViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-17.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSResultViewController.h"
#import "TSCoLtdpost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSfactoryTableViewController.h"



@interface TSResultViewController ()


@property (strong, nonatomic) SearchThridTableViewController *SearchThridTableViewController;


@end

@implementation TSResultViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initSearchbar
{
     _SearchThridTableViewController=[[SearchThridTableViewController alloc]initWithSearchTxt:_searchtxt target:self action:@selector(SearchButtonClicked:)];
   // _SearchThridTableViewController.delegate=self;
    
}
//TsSearchbarProtocol
-(void)SearchButtonClicked:(NSString *)searchBartxt
{
    _searchtxt = searchBartxt;
    [self getData];
}


- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    if ( _danweitype!=nil) {
        [dic setObject:_danweitype forKey:@"CardType"];
    }
    if (_section !=nil) {
        [dic setObject:_section forKey:@"CardAear"];
    }
    if (_searchtxt != nil) {
        [dic setObject:_searchtxt forKey:@"queryname"];
    }
    [dic setObject:[NSString stringWithFormat:@"%u",_page] forKey:@"pageindex"];
    
    NSURLSessionDataTask * task = [TSCoLtdpost globalTimeGetRecommendInfoWithDictionary:dic Block:^(NSArray *posts,NSUInteger maxcount, NSError *error) {
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
    
    //[UIActivityIndicatorView set ]
}




- (NSString *)makeDisplyString:(NSString *)peopleName telephoneNumber:(NSString *)telephoneNumber homeNumber:(NSString *)homeNumber address:(NSString *)address cardtype:(NSString *)cardtype
{
    NSMutableString * displayStr = [[NSString string]mutableCopy];
    
    if ([cardtype isEqualToString:@"C"])
    {
        if (![peopleName isKindOfClass:[NSNull class]] && peopleName.length > 0) {
            
            displayStr = [NSMutableString stringWithFormat:@"负  责  人: %@",peopleName];
            
        }
        if (![telephoneNumber isKindOfClass:[NSNull class]] && telephoneNumber.length > 0) {
            
            [displayStr appendFormat:@"\n电话号码: %@",telephoneNumber];
            
        }
        if (![homeNumber isKindOfClass:[NSNull class]] && homeNumber.length > 0) {
            
            [displayStr appendFormat:@"\n手       机: %@",homeNumber];
            
        }
    }
    else  if (![address isKindOfClass:[NSNull class]] && address.length > 0)
    {
        [displayStr appendFormat:@"%@",address];
    }
    return displayStr;
    
}

-(void)dealloc
{
    if ([_SearchThridTableViewController.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow] ) {
        [_SearchThridTableViewController.tableView removeFromSuperview];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 1;
    [self initSearchbar];
    [self setupRefresh];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------




//////////////////////search bar//////////////////////////////////////////////////////////////////
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
    return _posts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSCoLtdpost *post=[_posts objectAtIndex:indexPath.row];
    if ([post.CardType isEqualToString:@"C"]) {
        return 100;
    }
    else{
        return 60;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    }
    TSCoLtdpost *post=[_posts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = post.CardName;
    [cell.textLabel setTextColor:[UIColor grayColor]];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    
    

    
#pragma mark----------------调整行间距,设置detailTextLable-----------------
    
    [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
    [cell.detailTextLabel setNumberOfLines:0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *string=[self makeDisplyString:post.CntctPrsn telephoneNumber:post.Cellolar homeNumber:post.Phone1 address:post.Address cardtype:post.CardType];
    NSMutableAttributedString * attributtedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:1.0f];
    [attributtedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    cell.detailTextLabel.attributedText = attributtedString;
    
    [cell.detailTextLabel sizeToFit];
        
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSCoLtdpost *colpost=[_posts objectAtIndex:indexPath.row];
    if ([colpost.CardType isEqualToString: @"S"]) {
        TSfactoryTableViewController * viewController = [[TSfactoryTableViewController alloc]initWithStyle:UITableViewStylePlain];
        
        viewController.Coltdpost = [_posts objectAtIndex:indexPath.row];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }

}



@end
