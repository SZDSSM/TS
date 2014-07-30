//
//  TSMakeViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-17.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSMakeViewController.h"
#import "TSResultViewController.h"
#import "AFNetworking.h"

#import "CardShuaiXuanTableViewController.h"
#import "SearchThridTableViewController.h"

#define saparator @"-------------------------------------------------------------------------------------------------------"

@interface TSMakeViewController ()

//searchbar 相关

@property (strong, nonatomic) SearchThridTableViewController *SearchThridTableViewController;

@property (strong, nonatomic) NSMutableArray * array;
@property (strong, nonatomic) NSDictionary * DataDic;

@end

@implementation TSMakeViewController

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
    if ([_danweitype isEqualToString:@"生产厂家"]) {
        _SearchThridTableViewController=[[SearchThridTableViewController alloc]initWithSearchesKey:@"CardSearchesKey" SearchPlaceholder:NSLocalizedString(@"cardsearchplaceholder", @"") searchtext:nil rightButtonTitle:@"筛选" target:self action:@selector(SearchButtonClicked:)];
        [_SearchThridTableViewController shuaixuanAtTarget:self action:@selector(shaixuan)];
    }else{
        _SearchThridTableViewController=[[SearchThridTableViewController alloc]initWithSearchesKey:@"CardSearchesKey" SearchPlaceholder:NSLocalizedString(@"cardsearchplaceholder", @"") searchtext:nil rightButtonTitle:nil target:self action:@selector(SearchButtonClicked:)];
        [_SearchThridTableViewController shuaixuanAtTarget:self action:@selector(shaixuan)];
    }
}
//TsSearchbarProtocol
-(void)SearchButtonClicked:(NSString *)searchBartxt
{
    TSResultViewController * viewController = [[TSResultViewController alloc]init];
    viewController.searchtxt = searchBartxt;
    viewController.danweitype=_danweitype;
    //[viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)_initData
{
    NSString * touchurl = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetRegionList.ashx";
    NSString *URLTmp1 = [touchurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    touchurl = URLTmp1;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: touchurl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];

        //系统自带JSON解析
        if (resData != nil) {
            //将获取到的数据JSON解析到数组中
            NSError *error;
            self.DataDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error];
            _array = [NSMutableArray arrayWithCapacity:40];

            for (NSDictionary * dic in  [self.DataDic objectForKey:@"Region"]) {
                [_array addObject:[dic objectForKey:@"descript"]];
            }
            [self.tableView reloadData];
        }
            else if(nil == resData){
                UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [AlertView1 show];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Failure: %@", error);
            UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [AlertView1 show];
        }];
        [operation start];
}

//-(void)dealloc
//{
//    if ([_SearchThridTableViewController.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow] ) {
//        [_SearchThridTableViewController.tableView removeFromSuperview];
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _init];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self.navigationItem.leftBarButtonItem setTitle:@"a"];
}

- (void)_init
{
    [self _initData];
    
    [self initSearchbar];
    
    
    self.tableView.rowHeight = 55;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)shaixuan
{
    CardShuaiXuanTableViewController * viewController = [[CardShuaiXuanTableViewController alloc]init];
    [viewController shuaixuanAtTarget:self action:@selector(updateWithShuaixuan:)];
    UINavigationController *shuaixuanNavigation=[[UINavigationController alloc]initWithRootViewController:viewController];
//    viewController.yixuan=_SalesAear;
    [self presentViewController:shuaixuanNavigation animated:YES completion:nil];
}

//筛选页面 回调
-(void)updateWithShuaixuan:(NSString *)shuaixuanstring
{
//    _SalesAear=shuaixuanstring;
    TSResultViewController *viewController = [[TSResultViewController alloc]init];
    
    viewController.SalesAear=shuaixuanstring;
    viewController.danweitype = self.danweitype;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstid"];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstid"];
    }
    
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel * Separatorlabel = [[UILabel alloc]init];
    Separatorlabel.frame = CGRectMake(15, 46, ScreenWidth - 30, 1);
    Separatorlabel.backgroundColor = [UIColor whiteColor];
    Separatorlabel.text = saparator;
    Separatorlabel.textColor = [UIColor lightGrayColor];
    UILabel * Separatorlabel1 = [[UILabel alloc]init];
    Separatorlabel1.frame = CGRectMake(15, 47, ScreenWidth - 30, 1);
    Separatorlabel1.backgroundColor = [UIColor whiteColor];
    Separatorlabel1.text = saparator;
    Separatorlabel1.textColor = [UIColor lightGrayColor];
    
    //    [cell.contentView addSubview:Separatorlabel];
    [cell.contentView addSubview:Separatorlabel1];
    
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle=self.sectionViewTitle;
    if (sectionTitle==nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(15, 9, 300, 22);
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont boldSystemFontOfSize:17];
    label.text=sectionTitle;
    
    UILabel * linelable = [[UILabel alloc] init];
    linelable.frame = CGRectMake(0, 39, ScreenWidth, 1);
    linelable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    [sectionView addSubview:label];
    [sectionView addSubview:linelable];
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    NSUInteger row = indexPath.row;
    
    TSResultViewController *viewController = [[TSResultViewController alloc]init];
    viewController.section = [self.array objectAtIndex:[indexPath row]];
    viewController.danweitype = self.danweitype;
    [self.navigationController pushViewController:viewController animated:YES];
    

}

@end
