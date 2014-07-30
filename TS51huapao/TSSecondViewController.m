//
//  TSSecondViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-3-27.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "AFNetworking.h"
//#import "SearchThridTableViewController.h"
#import "FristSearchTableViewController.h"
#import "TSSecondViewController.h"
#import "TSSecondResultTableViewController.h"

@interface TSSecondViewController ()

//@property (strong, nonatomic) SearchThridTableViewController *SearchThridTableViewController;
@property (strong, nonatomic) FristSearchTableViewController *SearchViewController;

@property (nonatomic, strong) NSDictionary * getDic;
@property (nonatomic, strong) NSDictionary * getDic1;

@property (nonatomic)BOOL isOpen;

@property (nonatomic,strong) NSIndexPath * selectIndex;
@property (nonatomic, strong) NSMutableArray * dataList;

@property (nonatomic, strong) NSMutableArray * zuhe;


//@property (nonatomic,retain)IBOutlet UITableView *expansionTableView;

//@property (copy, nonatomic)  NSString *searchtext;
@end

@implementation TSSecondViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initSearchBar];
    [self _initData];
    [self getChicun];
    self.isOpen = NO;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    
    
//    NSLog(@"%@",[TSUser sharedUser].vipcode);
    //self.searchDisplayController.displaysSearchBarInNavigationBar = YES;
    
}

- (void)_initData
{
    
    NSString * touchurl = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetItemGroupList.ashx";
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
            self.getDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error];
            self.dataList = [self.getDic objectForKey:@"TSItmsGrp"];
            [self.tableView reloadData];
            
        }else if(nil == resData){
            UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [AlertView1 show];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [AlertView1 show];
    }];
    [operation start];
    
    
}

- (void)getChicun
{
    NSString * touchurl = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetTZspecList.ashx";
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
            self.getDic1 = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error];
            self.zuhe = [[self.getDic1 objectForKey:@"TSItemTZspec"]mutableCopy];
            [_zuhe insertObject:@{@"spec": @"全部"} atIndex:0];
            //            [self.tableView reloadData];
            
        }else if(nil == resData){
            UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [AlertView1 show];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [AlertView1 show];
    }];
    [operation start];
    
}

- (void)_initSearchBar
{
    //导航条的搜索条
    _SearchViewController=[[FristSearchTableViewController alloc]initWithSearchesKey:@"ItemSearchesKey" SearchPlaceholder:NSLocalizedString(@"itemsearchplaceholder", @"") target:self action:@selector(SearchButtonClicked:)];
    
    //_SearchThridTableViewController=[[SearchThridTableViewController alloc]initWithSearchesKey:@"ItemSearchesKey" SearchPlaceholder:NSLocalizedString(@"itemsearchplaceholder", @"") target:self action:@selector(SearchButtonClicked:)];
}

-(void)SearchButtonClicked:(NSString *)searchBartxt
{
    TSSecondResultTableViewController * viewController = [[TSSecondResultTableViewController alloc] init];
    viewController.searchtext = searchBartxt;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [self.zuhe count]+1;
        }
    }
    
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen) {
        if (self.selectIndex.section == indexPath.section){
            if (indexPath.row != 0) {
                return 30;
            }else
                return 50;
        }
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[_dataList objectAtIndex:indexPath.section]objectForKey:@"ItmsGrpNam"];
    cell.detailTextLabel.text = [[_dataList objectAtIndex:indexPath.section]objectForKey:@"ItmsGrpNote"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if ([cell.textLabel.text isEqualToString:@"组合烟花类"]) {
        self.selectIndex = indexPath;
        if (!self.isOpen) {
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            UIImageView * acce = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownAccessory"]];
            cell.accessoryView = acce;
            
        }
    }else{
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (self.isOpen&&indexPath.section == self.selectIndex.section) {
        if (indexPath.row!=0) {
            cell.textLabel.text = [NSString stringWithFormat:@"\t%@",[[_zuhe objectAtIndex:indexPath.row - 1]objectForKey:@"spec"]];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.text = @" ";
            cell.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:247.0/255.0];
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else
        return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        
        NSString *sectionTitle=@"选择产品分类";
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
        [sectionView setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:235.0/255.0]];
        [sectionView addSubview:label];
        [sectionView addSubview:linelable];
        return sectionView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == self.selectIndex.section) {
        if (indexPath.row == 0) {
            
            
            NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
            [self.tableView beginUpdates];
            for (int i = 0; i<[self.zuhe count]; i++) {
                NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i + 1 inSection:self.selectIndex.section];
                [rowToInsert addObject:indexPathToInsert];
            }
            if (self.isOpen) {
                [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
                self.isOpen = !self.isOpen;
                if (indexPath.row == 0) {
                    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    [tableView cellForRowAtIndexPath:indexPath].accessoryView = nil;
                }
                
            }else{
                [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
                self.isOpen = !self.isOpen;
                if (indexPath.row == 0) {
                    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
                    UIImageView * acce = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownAccessory"]];
                    [tableView cellForRowAtIndexPath:indexPath].accessoryView = acce;
                }
                
            }
            [self.tableView endUpdates];
            if (self.isOpen)
                [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        else{
            TSSecondResultTableViewController * viewController = [[TSSecondResultTableViewController alloc] init];
            
            viewController.itemname = [NSString stringWithFormat:@"组合烟花类%@",[self changeName:[[_zuhe objectAtIndex:indexPath.row-1]objectForKey:@"spec"]]];
            viewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:viewController animated:YES];
            
        }} else{
            TSSecondResultTableViewController * viewController = [[TSSecondResultTableViewController alloc] init];
            viewController.itemname = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            viewController.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (NSString *)changeName:(NSString *)name
{
    if ([name isEqualToString:@"全部"]) {
        return @"";
    }
    return name;
}



@end
