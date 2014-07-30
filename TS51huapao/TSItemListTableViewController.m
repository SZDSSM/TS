//
//  TSItemListTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-13.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSItemListTableViewController.h"
#import "TSItemTableViewCell.h"
#import "TSItemListPost.h"
#import "UIKit+AFNetworking.h"
#import "ItemSearchTableViewController.h"
#import "TSSecondResultTableViewController.h"


@interface TSItemListTableViewController ()

@property (strong, nonatomic) NSString * rankType;
@property (strong, nonatomic) NSArray * posts;


@property(strong,nonatomic)ItemSearchTableViewController *searchbarControl;

@end

@implementation TSItemListTableViewController

- (id)initWithRankType:(NSString *)rankType
{
    self = [super init];
    
    self.rankType = rankType;
    
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

- (void)viewDidLoad
{
    if ([self.rankType isEqualToString:@"S"]) {
        self.title = @"销售排行";

    }else if ([self.rankType isEqualToString:@"N"]) {
        self.title = @"新品排行";
        
    }else if ([self.rankType isEqualToString:@"J"]) {
        self.title = @"降价排行";
        
    }
    [super viewDidLoad];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)]];
    
    
    [self getData];
    UINib * nib = [UINib nibWithNibName:@"TSItemTableViewCell" bundle:nil];
    self.tableView.rowHeight = 65;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
    
   
    _searchbarControl=[[ItemSearchTableViewController alloc]initWithSearchesKey:@"ItemSearchesKey" SearchPlaceholder:NSLocalizedString(@"itemsearchplaceholder", @"") target:self action:@selector(searchButtonClick:)];
    
}

-(void)searchButtonClick:(NSString *)searchText
{
    TSSecondResultTableViewController * viewController = [[TSSecondResultTableViewController alloc] init];
    viewController.searchtext = searchText;
    viewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)backbutton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData
{
    NSURLSessionDataTask * task = [TSItemListPost globalTimeGetRecommendInfoWithRanktype:self.rankType Block:^(NSArray * posts, NSError *error) {
        //NSLog(@"error::%@",error);
        if (!error) {
            self.posts = posts;
            [self.tableView reloadData];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
        //[UIActivityIndicatorView set ]
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    if (nil == cell) {
        cell = [[TSItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.post = [self.posts objectAtIndex:indexPath.row];
    cell.sender=self;
    cell.order.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    if (indexPath.row == 0) {
        cell.order.textColor = [UIColor redColor];
        cell.order.font = [UIFont italicSystemFontOfSize:35];

    }else if(indexPath.row == 1){
        cell.order.textColor = [UIColor redColor];
        cell.order.font = [UIFont italicSystemFontOfSize:30];
    }else if (indexPath.row == 2){
        cell.order.textColor = [UIColor redColor];
        cell.order.font = [UIFont italicSystemFontOfSize:25];
    }else{
        cell.order.textColor = [UIColor grayColor];
        cell.order.font = [UIFont italicSystemFontOfSize:17];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}




#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSItemTableViewCell *cell=(TSItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell pushtoItemDetailView];
}


@end
