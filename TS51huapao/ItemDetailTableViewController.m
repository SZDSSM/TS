//
//  ItemDetailTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "xiadanTableViewController.h"
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
#import "TSAppDoNetAPIClient.h"
@interface ItemDetailTableViewController ()

@property (nonatomic, copy) void (^xiadanCallback)(int orderQty);

@property (strong, nonatomic)TSItemDetailPost * post;

@property(nonatomic,assign)int ordrQty;
@property (strong, nonatomic) NSString  * replty;

@property (strong, nonatomic) NSArray  * commentPost;


@property (strong, nonatomic)UIView * photoSectionView;
@property (strong, nonatomic)UIView * commentSectionView;

@property (strong, nonatomic)UIButton * button;

@property (strong, nonatomic)UIButton * xiadan;
@property (strong, nonatomic)UIButton * kanyang;
@property (strong, nonatomic)UIView * statusView;
@property (strong, nonatomic)UIView * bottomView;

@end

@implementation ItemDetailTableViewController


- (void)xiadanCallback:(void (^)(int orderQty))callback
{
    self.xiadanCallback=callback;
}

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
    
    if ([TSUser sharedUser].USERTYPE==TSManager) {
        [self _initBottomView];
    }
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
                _ordrQty=[post.orderQuantity intValue];
                
                if ([_post.photolist isEqual:[NSNull null]]) {
                    _post.photolist=[NSArray array];
                }
                if (_post.photolist.count>0) {
                    _photoSectionView=[self SectionViewWithTitle:@"图文详情:"];
                }
                [self getCommentData];
                [self updateBottomView];
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
            cell.delegate=_GuanZhudelegate;
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
    
    
    _button = [[UIButton alloc]init];
    [_button addTarget:self action:@selector(backButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [_button backStyle];

}
-(void)updateBottomView
{
    if ([_post.orderQuantity floatValue]>0) {
        [_xiadan setTitle:@"修改下单" forState:UIControlStateNormal];
    }else{
        [_xiadan setTitle:@"下单" forState:UIControlStateNormal];
    }

    if ([_post.IsInSeeSamp isEqualToString:@"Y"]) {
        [_kanyang setTitle:@"取消看样" forState:UIControlStateNormal];
    }else{
        [_kanyang setTitle:@"看样" forState:UIControlStateNormal];
    }
}
-(void)_initBottomView
{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    [_bottomView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:0.9]];
    _xiadan = [[UIButton alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth/2-15, 36)];
    
    
    [_xiadan addTarget:self action:@selector(xiadanbackButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [_xiadan defaultStyle];
    
    _kanyang = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2+5,  7, ScreenWidth/2-15, 36)];

    
    [_kanyang addTarget:self action:@selector(kanyangbackButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [_kanyang defaultStyle];
    [_bottomView addSubview:_xiadan];
    [_bottomView addSubview:_kanyang];
}
- (void)backButtonTap:(UIButton *)sender
{
    //取消看样回调 预约看样列表
    if ([_post.IsInSeeSamp isEqualToString:@"N"]&&[_KanYandelegate respondsToSelector:@selector(KanYanButtonClicked)]) {
        [_KanYandelegate KanYanButtonClicked];
    }
    //下单数量变更后回调 意向订单列表
    if (self.xiadanCallback && _ordrQty!=[_post.orderQuantity intValue]) {
        self.xiadanCallback([_post.orderQuantity intValue]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden=NO;
}

- (void)xiadanbackButtonTap:(UIButton *)sender
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    xiadanTableViewController *xiadanview = [board instantiateViewControllerWithIdentifier:@"xiadanTableview"];
    xiadanview.post=_post;
    [xiadanview xiadanAtTarget:self action:@selector(updateBottomView)];
    UINavigationController *xiadanviewNavigation=[[UINavigationController alloc]initWithRootViewController:xiadanview];
    [self presentViewController:xiadanviewNavigation animated:YES completion:^{
        if ([_post.orderQuantity hasPrefix:@"0"]) {
            [xiadanview.qty becomeFirstResponder];
        }else{
            [xiadanview changeInfo:nil];
        }
    }];
//    [self.navigationController pushViewController:xiadanviewNavigation animated:YES];
}
- (void)kanyangbackButtonTap:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"看样"]) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"看样"
                                  message:@"将该产品添加至你的看样列表，51花炮服务人员看到你的请求后会尽快安排预约看样或进一步的联系你"
                                  delegate:self
                                  cancelButtonTitle:@"添加"
                                  otherButtonTitles:@"关闭", nil];
        [alertView show];
    }else if ([sender.titleLabel.text isEqualToString:@"取消看样"]) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"取消看样"
                                  message:@"确认取消对该产品的预约看样"
                                  delegate:self
                                  cancelButtonTitle:@"取消看样"
                                  otherButtonTitles:@"关闭", nil];
        [alertView show];
    }
    
}

#pragma  mark-- 实现UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertView.title isEqual:@"看样"]) {
        if (buttonIndex==0) {
            [self addToSeeSamp];
        }
    }else if ([alertView.title isEqual:@"取消看样"]) {
        if (buttonIndex==0) {
            [self delFromSeeSamp];
        }
    }
    
}
-(void)addToSeeSamp
{
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxAddSampleItem.ashx" parameters:@{@"vipcode":[TSUser sharedUser].vipcode,@"itemcode":_post.ItemCode} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            [_post setIsInSeeSamp:@"Y"];
            [_kanyang setTitle:@"取消看样" forState:UIControlStateNormal];
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"成功"
                                      message:@"添加至预约看样列表"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:alertView
                                            repeats:NO];
            [alertView show];
        }else if ([rslt isEqualToString:@"false"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"添加预约看样失败"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:alertView
                                            repeats:NO];
            [alertView show];
        }else if ([rslt isEqualToString:@"repetition"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"该物料已在我的预约看样列表"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:alertView
                                            repeats:NO];
            [alertView show];
        }else if ([rslt isEqualToString:@"notExists"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"该物料不存在"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:alertView
                                            repeats:NO];
            [alertView show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:[error localizedDescription]
                                  delegate:nil
                                  cancelButtonTitle:@"关闭"
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
}
-(void)delFromSeeSamp
{
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxDelSampleItem.ashx" parameters:@{@"vipcode":[TSUser sharedUser].vipcode,@"itemcode":_post.ItemCode} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            [_post setIsInSeeSamp:@"N"];
            [_kanyang setTitle:@"看样" forState:UIControlStateNormal];
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"成功"
                                      message:@"已取消预约看样"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:alertView
                                            repeats:NO];
            [alertView show];
        }else if ([rslt isEqualToString:@"false"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"取消操作失败"
                                      delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:alertView
                                            repeats:NO];
            [alertView show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:[error localizedDescription]
                                  delegate:nil
                                  cancelButtonTitle:@"关闭"
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
@end
