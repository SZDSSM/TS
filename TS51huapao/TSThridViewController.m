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

//#import "SearchThridTableViewController.h"
#import "FristSearchTableViewController.h"


#define saparator @"-------------------------------------------------------------------------------------------------------"

@interface TSThridViewController ()


@property (strong, nonatomic) NSArray * array;

//@property (strong, nonatomic) SearchThridTableViewController *SearchThridTableViewController;
@property (strong, nonatomic) FristSearchTableViewController *SearchViewController;


@end

@implementation TSThridViewController

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
    //获取数据
    
    self.array = @[@"生产厂家",@"经销商",@"原辅材料",@"政府部门"];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initSearchbar];
    
//    UIBarButtonItem *backbut=[[UIBarButtonItem alloc] initWithTitle:@"返回123"
//                                                              style:UIBarButtonItemStyleBordered
//                                                             target:self
//                                                             action:@selector(backButton)];
//    [backbut setTintColor:[UIColor lightGrayColor]];
//    self.navigationItem.backBarButtonItem =backbut;
    
}


- (void)initSearchbar
{
    _SearchViewController=[[FristSearchTableViewController alloc]initWithSearchesKey:@"CardSearchesKey"SearchPlaceholder:NSLocalizedString(@"cardsearchplaceholder", @"")  target:self action:@selector(SearchButtonClicked:)];
//    _SearchThridTableViewController=[[SearchThridTableViewController alloc]initWithSearchesKey:@"CardSearchesKey" SearchPlaceholder:NSLocalizedString(@"cardsearchplaceholder", @"") target:self action:@selector(SearchButtonClicked:)];

}
//TsSearchbarProtocol
-(void)SearchButtonClicked:(NSString *)searchBartxt
{
    TSResultViewController * viewController = [[TSResultViewController alloc]init];
    //[viewController setHidesBottomBarWhenPushed:YES];
    viewController.searchtxt = searchBartxt;
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
            viewController.sectionViewTitle = @"根据区域选择生产厂家";
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
    if ([tableView isEqual:self.tableView]) {
        return 40;
    }else{
        return 0;
    }
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
    linelable.frame = CGRectMake(0, 39, ScreenWidth, 1);
    linelable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    //    UIImageView * imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"51huapao"]];
    //    imageV.frame = CGRectMake(40, 40, 100, 100);
    
    
    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
    [sectionView setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]];
    [sectionView addSubview:label];
    [sectionView addSubview:linelable];
    
    //    [sectionView addSubview:imageV];
    return sectionView;
}




@end
