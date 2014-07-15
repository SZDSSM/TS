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
#import "WebViewController.h"

static NSString*const BaseURLString = @"http://51.laimimi.com/zixun/newslist.asp?id=";

@interface TSForthViewController ()

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
    [self _initBigImageView];
    [self recieve:@"http://51.laimimi.com/zixun/newslist.asp?id=102"];
    [self _initNewsTableVeiw];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.newstableView reloadData];
}

- (void)_initTopView {
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 49)];
//    _topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topView_background.png"]];
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
       // button.titleLabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:179.0/255.0 green:176.0/255.0 blue:172.0/255.0 alpha:1.0];
        if (i==0)
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        else
        [button setTitleColor:[UIColor colorWithRed:179.0/255.0 green:176.0/255.0 blue:172.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [button setFont:[UIFont systemFontOfSize:13]];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:button];
        
    }
//    CGRect frame = CGRectMake([self.view viewWithTag:0].frame.origin.x+20, [self.view viewWithTag:0].frame.origin.y+[self.view viewWithTag:0].frame.size.height, [self.view viewWithTag:0].frame.size.width-40, 1);
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
    NSString * urlstr = [[NSString alloc]init];
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
    if (button.tag == 102)
        urlstr = [BaseURLString stringByAppendingString:@"102"];
    else if (button.tag == 103)
        urlstr = [BaseURLString stringByAppendingString:@"103"];
    else if (button.tag == 104)
        urlstr = [BaseURLString stringByAppendingString:@"104"];
    else if (button.tag == 105)
        urlstr = [BaseURLString stringByAppendingString:@"105"];
//    return urlstr;
//    [self.array removeAllObjects];
    [self recieve:urlstr];
    [self.newstableView reloadData];
}

- (void)_initBigImageView
{

    UIImageView * bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 113, ScreenWidth, 157)];
    [bigImageView setImage:[UIImage imageNamed:@"1.png"]];
    [bigImageView setBackgroundColor:[UIColor blackColor]];

    bigImageView.contentMode = UIViewContentModeCenter;
    
    _bigimageView = bigImageView;
    [self.view addSubview:_bigimageView];
    
}

- (void)_initNewsTableVeiw
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.bigimageView.frame.origin.y + self.bigimageView.frame.size.height, ScreenWidth, ScreenHeight-self.bigimageView.frame.origin.y-self.bigimageView.frame.size.height-49) style:UITableViewStylePlain];

    self.newstableView = tableView;
    
    self.newstableView.delegate = self;
    self.newstableView.dataSource = self;
    [self.view addSubview:self.newstableView];
}

- (void)recieve:(NSString *)urlstr
{
//    NSString *URLTmp = @"http://51.laimimi.com/zixun/newslist.asp?id=103";
    NSString *URLTmp1 = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    urlstr = URLTmp1;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: urlstr]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
//        NSLog(@"data:::::::%@",resData);
        //系统自带JSON解析
        if (resData != nil) {
            //将获取到的数据JSON解析到数组中
            NSError *error;
          NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error];
            self.array = [dic objectForKey:@"NewsDataIOS"];
            NSLog(@"%lu",(unsigned long)[self.array count]);
//            [self _initNewsTableVeiw];
            [self.newstableView reloadData];
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
    NSLog(@"%lu",(unsigned long)[self.array count]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
    NSLog(@"%lu",(unsigned long)[self.array count]);

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    TSForthViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TSForthViewControllerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic=[self.array objectAtIndex:indexPath.row];
    cell.title.text=[dic objectForKey:@"NTitle"];
    cell.content.text=[dic objectForKey:@"NContent"];
    
    NSURL *url=[NSURL URLWithString:[dic objectForKey:@"NImages"]];
    NSLog(@"%@",url);
    
//    [cell.image setImageWithURL:url placeholderImage:[UIImage imageNamed:@"detalis_thubmail.png"]];
    
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
//    NSLog(@"====%@==",content);
//    LogsInfoViewController *_logsInfo_vc=[[LogsInfoViewController alloc] init];
    WebViewController *_webVC = [[WebViewController alloc] init];
    _webVC.hidesBottomBarWhenPushed = YES;
//    [_logsInfo_vc setInfo:content];
    [_webVC setUrlstr:urlstr];
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
