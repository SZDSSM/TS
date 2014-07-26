//
//  ItemDetailTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "ItemDetail1TableViewCell.h"
#import "ItemDetailTableViewController.h"
#import "WebViewController.h"
#import "TSItemDetailPost.h"
#import "UIKit+AFNetworking.h"
#import "UIScrollView+MJRefresh.h"
#import "TSStarRatingView.h"
#import "UIButton+Style.h"
#import "MJRefresh.h"
#import "TSItemCommentPost.h"
#import "UIView+FoxExtras.h"

@interface ItemDetailTableViewController ()

@property (strong, nonatomic)TSItemDetailPost * post;

@property (strong, nonatomic) NSString  * replty;

@property (strong, nonatomic) NSArray  * commentPost;


@property (strong, nonatomic)UIView * photoSectionView;
@property (strong, nonatomic)UIView * commentSectionView;

@property (strong, nonatomic)UIButton * button;
@property (strong, nonatomic)UIView * statusView;
@property (strong, nonatomic)UIView * bottomView;

@end

@implementation ItemDetailTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(UIView *)SectionViewWithTitle:(NSString *)title
{
    NSString *sectionTitle=title;
    if (sectionTitle==nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(20, 6, 300, 22);
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor lightGrayColor];
    label.font=[UIFont systemFontOfSize:15];
    label.text=sectionTitle;
    
    UILabel *linelable = [[UILabel alloc] init];
    linelable.frame = CGRectMake(0, 34, ScreenWidth, 1);
    linelable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 35)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    [sectionView addSubview:label];
    [sectionView addSubview:linelable];
    
    if ([title isEqualToString:@"点评:"]) {
        UILabel *replty = [[UILabel alloc] init];
        replty.frame = CGRectMake(ScreenWidth-110, 5, 100, 30);
        replty.textColor=[UIColor redColor];
        label.font=[UIFont systemFontOfSize:14];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[@"好评度: " stringByAppendingString:_replty]];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"TrebuchetMS-Bold" size:12.0] range:NSMakeRange(0,4)];
        //_labelCurrentPrice.text=cp;
        replty.attributedText=str;

        [sectionView addSubview:replty];
    }
    
    return sectionView;
}



//-(void)dealloc
//{
//    NSLog(@"dealloc::itemdetailtableview");
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _initKeyViewButton];
    [self setupRefresh];
    //[self getData];
    self.navigationController.navigationBarHidden=YES;
}

-(void)getData
{
    NSURLSessionDataTask * task = [TSItemDetailPost globalTimeGetRecommendInfoWithItemcode:_itemcode Block:^(TSItemDetailPost *post, NSError *error) {
        if (!error) {
            if ([post.ItemCode length]>5) {
                self.post = post;
                if ([_post.photolist isEqual:[NSNull null]]) {
                    _post.photolist=[NSArray array];
                }
                if (_post.photolist.count>0) {
                    _photoSectionView=[self SectionViewWithTitle:@"图文详情:"];
                }
                [self getCommentData];
                [self.tableView reloadData];
                
                UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 110.0f)];
                self.tableView.tableFooterView =[view addRecommndFooterView:self];
                
                [[UIApplication sharedApplication].keyWindow addSubview:_bottomView];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"未获取到数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            }
        }
        [self.tableView headerEndRefreshing];
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)getCommentData
{
    NSURLSessionDataTask * task = [TSItemCommentPost globalTimeGetCommentInfoWithItemcode:_itemcode Block:^(NSArray * posts,NSString *replty, NSError *error) {
        if (!error) {
            _replty=replty;
            if (![posts isEqual:[NSNull null]]) {
                _commentPost = posts;
            }else{
                _commentPost=[NSArray array];
            }
            if (_commentPost.count>0) {
                _commentSectionView=[self SectionViewWithTitle:@"点评:"];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
    //[UIActivityIndicatorView set ]
}



- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.tableView addHeaderWithTarget:self action:@selector(getData)];
    
    [self.tableView headerBeginRefreshing];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _post.photolist=nil;
    _commentPost=nil;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_post.ItemCode length]>5) {
        return 6;
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return _post.photolist.count;
    }
    else if(section==4)
    {
        if([_post.IsEnsure isEqualToString:@"N"] &&[_post.IsFreeShip isEqualToString:@"N"]&&[_post.IsTrade isEqualToString:@"N"]&&[_post.IsQaTest isEqualToString:@"N"])
            return 0;
        else
            return 2;
    }
    else if(section==5)
    {
        return _commentPost.count;
    }
    else{
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            ItemDetail1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailCell1"];
            cell.post=_post;
            cell.sender=self;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separator"];
            return cell;
        }

    }
    else if (indexPath.section==1){
        if (indexPath.row==0) {
            ItemDetail3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailCell3"];
            cell.post=_post;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separator"];
            return cell;
        }
    }
    else if (indexPath.section==2){
        if (indexPath.row==0) {
            ItemDetail2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailCell2"];
            cell.post=_post;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separator"];
            return cell;
        }
    }
    else if (indexPath.section==3){
        NSString *photoURL=[_post.photolist objectAtIndex:indexPath.row];
        ItemDetail4TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailCell4"];
        [cell.image setImageWithURL:[NSURL URLWithString:photoURL] placeholderImage:[UIImage imageNamed:@"noImage"]];
        return cell;
    }
    else if (indexPath.section==4){
        if (indexPath.row==0) {
            ItemDetail5TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailCell5"];
            cell.post=_post;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"separator"];
            return cell;
        }
    }
    else if (indexPath.section==5){
        ItemDetail6TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailCell6"];
        cell.post=[_commentPost objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemDetailCell3"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 300;
        }else{
            return 20;
        }
        
    }
    else if (indexPath.section==1){
        
        if (indexPath.row==0) {
            return 60;
        }else{
            return 20;
        }
    }
    else if (indexPath.section==2){
        
        if (indexPath.row==0) {
            return 134;
        }else{
            return 20;
        }
    }
    else if (indexPath.section==3){
        return 300;
    }
    else if (indexPath.section==4){
        
        if (indexPath.row==0) {
            return 60;
        }else{
            return 20;
        }
    }
    else if (indexPath.section==5){
            return 70;
    }
    else{
        return 20;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==3) {
        if (_post.photolist.count>0) {
            return _photoSectionView;
        }
    }
    else if(section==5)
    {
        return _commentSectionView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==3) {
        if (_post.photolist.count>0) {
            return 35;
        }
    }
    else if(section==5)
    {
        if (_commentPost.count>0) {
            return 35;
        }
    }
    return 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication].keyWindow addSubview:_statusView];
    [[UIApplication sharedApplication].keyWindow addSubview:_button];
    if (_post.ItemCode.length>5) {
        [[UIApplication sharedApplication].keyWindow addSubview:_bottomView];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_button removeFromSuperview];
    [_statusView removeFromSuperview];
    [_bottomView removeFromSuperview];
}

#pragma mark - Action
-(void)callButton:(id)sender
{
    NSString *phonenumber=@"4006751518";
    NSString *call=[NSString stringWithFormat:@"tel://%@",phonenumber];//telprompt 打电话前先弹框  是否打电话 然后打完电话之后回到程序中,可能不合法无法通过审核
    NSURL *callURL=[NSURL URLWithString:call];
    [[UIApplication sharedApplication] openURL:callURL];
}

- (void)_initKeyViewButton
{
    //    self.edgesForExtendedLayout=UIRectEdgeNone;
    _statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    [_statusView setBackgroundColor:[UIColor whiteColor]];
    
    
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    [_bottomView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:0.9]];
    UIButton * xiadan = [[UIButton alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth/2-15, 36)];
    [xiadan setTitle:@"下单" forState:UIControlStateNormal];
    [xiadan addTarget:self action:@selector(xiadanbackButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [xiadan defaultStyle];
    
    UIButton * kanyang = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2+5,  7, ScreenWidth/2-15, 36)];
    [kanyang setTitle:@"看样" forState:UIControlStateNormal];
    [kanyang addTarget:self action:@selector(kanyangbackButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [kanyang defaultStyle];
    [_bottomView addSubview:xiadan];
    [_bottomView addSubview:kanyang];
    
    
    _button = [[UIButton alloc]init];
    [_button addTarget:self action:@selector(backButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [_button backStyle];

}
- (void)backButtonTap:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
//    [_button removeFromSuperview];
//    [_statusView removeFromSuperview];
//    [_bottomView removeFromSuperview];
    self.navigationController.navigationBarHidden=NO;
}

- (void)xiadanbackButtonTap:(UIButton *)sender
{
}

- (void)kanyangbackButtonTap:(UIButton *)sender
{
}
@end
