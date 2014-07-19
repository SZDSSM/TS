//
//  TSThirdViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-17.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSThridViewController.h"
#import "TSMakeViewController.h"
#import "TSResultViewController.h"

#define saparator @"-------------------------------------------------------------------------------------------------------"


@interface TSThirdViewController ()

@property (strong, nonatomic)  UISearchBar *searchBar;
@property (strong, nonatomic) NSArray * array;

@end

@implementation TSThirdViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)_initData
{
    self.array = @[@"生产厂家",@"经销商",@"原辅材料",@"政府部门"];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(40.0f,0.0f,160,30)];
    
    [_searchBar setBarTintColor:[UIColor groupTableViewBackgroundColor]];
    [_searchBar setBarStyle:UIBarStyleDefault];
    [_searchBar setPlaceholder:@"请输入产品名称"];
    [_searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    self.searchBar.delegate = self;
    //    CGRect rect = _searchBar.frame;
    //    rect.origin.x = 40;
    //    _searchBar.frame = rect;
    
    
    self.navigationItem.titleView = _searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 30, 30)]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]initWithFrame:CGRectMake(280.0f, 0.0f, 30, 30)]];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
}

#pragma mark---------------searchBar delegate-----------

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    TSResultViewController * viewController = [[TSResultViewController alloc]init];
    //[viewController setHidesBottomBarWhenPushed:YES];
    viewController.searchtxt = self.searchBar.text;
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取数据
    [self _initData];
    
    
    
    
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
    Separatorlabel.frame = CGRectMake(15, 57, ScreenWidth - 30, 1);
    Separatorlabel.backgroundColor = [UIColor whiteColor];
    Separatorlabel.text = saparator;
    Separatorlabel.textColor = [UIColor lightGrayColor];
    UILabel * Separatorlabel1 = [[UILabel alloc]init];
    Separatorlabel1.frame = CGRectMake(15, 58, ScreenWidth - 30, 1);
    Separatorlabel1.backgroundColor = [UIColor whiteColor];
    Separatorlabel1.text = saparator;
    Separatorlabel1.textColor = [UIColor lightGrayColor];
    
    //    [cell.contentView addSubview:Separatorlabel];
    [cell.contentView addSubview:Separatorlabel1];
    
    //    [cell.contentView addSubview:Separatorlabel];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger row = indexPath.row;
    
    if (row == 0||row == 1) {
        TSMakeViewController *viewController = [[TSMakeViewController alloc]init];
        if (row == 0) {
            viewController.sectionViewTitle = @"根据定点备案区域选择生产厂家";
            viewController.danweitype = @"生产厂家";
        }else{
            viewController.sectionViewTitle = @"根据区域选择经销商";
            viewController.danweitype = @"经销商";
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark ---------------------自定义section--------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle=@"选择单位类型";
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
    linelable.frame = CGRectMake(0, 38, ScreenWidth, 2);
    linelable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    
    
    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:235.0/255.0]];
    [sectionView addSubview:label];
    [sectionView addSubview:linelable];
    return sectionView;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
