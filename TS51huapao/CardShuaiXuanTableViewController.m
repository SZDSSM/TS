//
//  CardShuaiXuanTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "CardShuaiXuanTableViewController.h"
#import "AFNetworking.h"


@interface CardShuaiXuanTableViewController ()

@property (nonatomic,weak)UIViewController *callbackViewControl;
@property(nonatomic)SEL func_selector;

@property (strong, nonatomic) NSMutableArray * array;
@property (strong, nonatomic) NSDictionary * DataDic;

@end

@implementation CardShuaiXuanTableViewController


-(void)shuaixuanAtTarget:(UIViewController *)target action:(SEL)action
{
    _callbackViewControl=target;
    _func_selector=action;
}

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
    [self _init];


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

- (void)_init
{
    [self _initData];
    
    self.title=@"厂家可销售区域";
    
    self.tableView.rowHeight = 45;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(quxiao:)];
    [item setTintColor:[UIColor grayColor]];
    
    //设置barbutton
    self.navigationItem.rightBarButtonItem = item;
}

- (void)quxiao:(id)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    if (_yixuan !=nil && [cell.textLabel.text  isEqualToString:_yixuan])
    {
        [cell.textLabel setTextColor:[UIColor redColor]];
        [cell.textLabel setFont:[UIFont systemFontOfSize:22.0]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        [cell.textLabel setFont:[UIFont systemFontOfSize:18.0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if( [_callbackViewControl respondsToSelector:_func_selector])
    {
        [_callbackViewControl performSelector:_func_selector withObject:[self.array objectAtIndex:indexPath.row] ];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
