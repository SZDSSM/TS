//
//  TSForthViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-9.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSForthViewController.h"
#import "TSForthViewControllerCell.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "WebViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

static NSString*const BaseURLString = @"http://51.laimimi.com/zixun/newslist.asp?tid=%@&page=%@";

@interface TSForthViewController ()

@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger pagecount;
@property (nonatomic, strong) NSString * nowId;
@property (nonatomic) NSUInteger lastTag;
@property (nonatomic) NSUInteger nowTag;

@property(nonatomic)BOOL isNetWorking;


@property(nonatomic,weak) AFHTTPRequestOperation *operation;

@end



@implementation TSForthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initTopView];
    //    [self _initBigImageView];
    _page = 1;
    _nowId = @"102";
    //    [self recieve:[NSString stringWithFormat:BaseURLString,_nowId,[NSNumber numberWithInteger:_page]]];
    _array = [[NSArray array]mutableCopy];
    
    [self headerRereshing];
    [self _initNewsTableVeiw];
    [self setupRefresh];
    [self.newstableView headerBeginRefreshing];//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    self.navigationController.navigationBarHidden = YES;
    
    _lastTag = _nowTag = 102;
    
}

- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.newstableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //[self.tableView headerBeginRefreshing];
    // 2.添加上拉刷新
    [self.newstableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

- (void)headerRereshing
{
    _page=1;
    [self recieve:[NSString stringWithFormat:BaseURLString,_nowId,[NSNumber numberWithInteger:_page]]];
}

- (void)footerRereshing
{
    if (_page<_pagecount) {
        _page=_page+1;
        [self recieve:[NSString stringWithFormat:BaseURLString,_nowId,[NSNumber numberWithInteger:_page]]];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"通知" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        //[alert show];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.newstableView footerEndRefreshing];
            [alert show];
        });
    }
}



//- (void)viewDidAppear:(BOOL)animated
//{
//    [self.newstableView reloadData];
//}
//
- (void)_initTopView {
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 49)];
    _topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_topView];
    
    NSArray * titles = @[@"头条",@"产业动态",@"专家专栏",@"政策法规"];
    
    
    for (int i=0; i<titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((i*ScreenWidth/4), (49-30)/2, (ScreenWidth/4)-2, 30);
        if (i) {
            [_topView addSubview:[self _initverticalline:CGRectMake((i*ScreenWidth/4)-1, (49-30)/2+5,  2, 20)]];
        }
        button.tag = i+102;
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        if (i==0)
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        else
            [button setTitleColor:[UIColor colorWithRed:179.0/255.0 green:176.0/255.0 blue:172.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:button];
        
    }
    CGRect frame = CGRectMake(1, (49-30)/2 + 30, ScreenWidth/4-2, 2);
    
    
    self.redLine = [[UIView alloc]initWithFrame:frame];
    [self.redLine setBackgroundColor:[UIColor redColor]];
    [_topView addSubview:self.redLine];
    [self.view addSubview:_topView];
}

- (UIView *)_initverticalline:(CGRect)rect
{
    UIView * vl = [[UIView alloc]initWithFrame:rect];
    vl.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:226.0/255.0];
    return vl;
}

- (void)reload:(UIButton *)button
{
    if (!_isNetWorking) {
        
    
    
    }
    [UIView animateWithDuration:.3f animations:^{
        self.redLine.frame = CGRectMake(button.frame.origin.x+1, button.frame.origin.y+button.frame.size.height, ScreenWidth/4-2, 2);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        for (int i = 0 ; i < 4; i++) {
            if (button.tag == i+102 )
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            else
                [(UIButton *)[self.view viewWithTag:i+102] setTitleColor:[UIColor colorWithRed:179.0/255.0 green:176.0/255.0 blue:172.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        }
    }];
    
    _page = 1;
    if (button.tag == 102)
    {
        _nowId = @"102";
    }
    
    else if (button.tag == 103)
    {
        _nowId = @"103";
    }
    else if (button.tag == 104)
    {
        _nowId = @"104";
    }
    else if (button.tag == 105)
    {
        _nowId = @"105";
    }
    if (button.tag != _lastTag) {
        if ([self.array count]) {
            [self.array removeAllObjects];
        }
        
        [self headerRereshing];
        [self.newstableView headerBeginRefreshing];
        _lastTag = button.tag;
    }
}

- (void)_initNewsTableVeiw
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight-122) style:UITableViewStylePlain];
    
    
    self.newstableView = tableView;
    
    self.newstableView.delegate = self;
    self.newstableView.dataSource = self;
    
    //    self.newstableView set
    
    [self.newstableView setTableHeaderView:({    UIImageView * bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 150)];
        if ([_array count]) {
            [bigImageView setImageWithURL:[NSURL URLWithString:[[_array objectAtIndex:0]objectForKey:@"NImages"]] placeholderImage:[UIImage imageNamed:@"1"]];
        }else{
            [bigImageView setImage:[UIImage imageNamed:@"1"]];
        }
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(push)];
        [bigImageView addGestureRecognizer:tap];
        tap.delegate = self;
        
        [bigImageView setBackgroundColor:[UIColor blackColor]];
        
        bigImageView.contentMode = UIViewContentModeCenter;
        
        bigImageView.userInteractionEnabled = YES;
        
        
        
        
        _bigimageView = bigImageView;
        [self.view addSubview:_bigimageView];
        bigImageView;
    })];
    
    
    [self.view addSubview:self.newstableView];
}

- (void)push
{
    if ([_array count]) {
        
        WebViewController *_webVC = [[WebViewController alloc] init];
        _webVC.hidesBottomBarWhenPushed = YES;
        [_webVC setUrlstr:[[self.array objectAtIndex:0]objectForKey:@"NUrl"]];
        
        [self.navigationController pushViewController:_webVC animated:YES];
    }
}

- (void)recieve:(NSString *)urlstr
{
    
    NSString *URLTmp1 = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    urlstr = URLTmp1;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: urlstr]];
    [_operation cancel];
    AFHTTPRequestOperation *operation= [[AFHTTPRequestOperation alloc] initWithRequest:request];
    _operation = operation;
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@", operation.responseString);
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        if (resData != nil) {
            //将获取到的数据JSON解析到数组中
            NSError *error;
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error];
            NSArray * temarr = [dic objectForKey:@"NewsDataIOS"];
            if ([temarr count]) {
                [self.array addObjectsFromArray:temarr];
            }
            self.pagecount = [[dic objectForKey:@"PageNum"]intValue];
//            NSLog(@"%lu",(unsigned long)[self.array count]);
            [self.newstableView reloadData];
        }else if(nil == resData){
            UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [AlertView1 show];
        }
        [self.newstableView headerEndRefreshing];
        [self.newstableView footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Failure: %@", error);
//        UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
//        [AlertView1 show];
        [self.newstableView headerEndRefreshing];
        [self.newstableView footerEndRefreshing];
    }];
    [_operation start];
    NSLog(@"%lu",(unsigned long)[self.array count]);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count]-1;
    NSLog(@"%lu",(unsigned long)[self.array count]);
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    TSForthViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TSForthViewControllerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic=[_array objectAtIndex:indexPath.row + 1];
    cell.title.text=[dic objectForKey:@"NTitle"];
    cell.content.text=[dic objectForKey:@"NContent"];
    [cell.image setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"NImages"]] placeholderImage:[UIImage imageNamed:@"noImage"]];
    //
    
    
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    
    NSDictionary *content=[self.array objectAtIndex:row];
    NSString *urlstr = [content objectForKey:@"NUrl"];
    
    WebViewController *_webVC = [[WebViewController alloc] init];
    _webVC.hidesBottomBarWhenPushed = YES;
    
    [_webVC setUrlstr:urlstr];
    [self.newstableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:_webVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
