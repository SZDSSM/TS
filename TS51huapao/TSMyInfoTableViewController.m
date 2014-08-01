//
//  TSMyInfoTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-25.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

//#define kNumberOfEditableRows         5
//#define kNameRowIndex                 0
//#define kMiMaRowIndex                 1
//#define kMiMaQueRenRowIndex           2
//#define kAgeIndex                     3
//#define kPhoneIndex                   4
//
//#define kLabelTag                     2048
//#define kTextFieldTag                 4094


#import "TSMyInfoTableViewController.h"
#import "TSAppDoNetAPIClient.h"

@interface TSMyInfoTableViewController ()

@property (nonatomic, strong)NSMutableArray * itemArray;
@property (nonatomic, strong)NSDictionary * getDic;
@property (nonatomic)BOOL xiugaitap;

@end

@implementation TSMyInfoTableViewController


/*
 [[TSAppDoNetAPIClient sharedClient] GET:@"FoxDelSampleItem.ashx" parameters:@{@"vipcode":_kanyangpost.Vipcode,@"itemcode":_kanyangpost.itemCode} success:^(NSURLSessionDataTask *task, id responseObject) {
 NSString *rslt=[responseObject objectForKey:@"result"];
 if ([rslt isEqualToString:@"true"]) {
 UIAlertView *alertView = [[UIAlertView alloc]
 initWithTitle:@"关闭预约"
 message:@"关闭预约看样成功"
 delegate:nil
 cancelButtonTitle:@"关闭"
 otherButtonTitles:nil, nil];
 [alertView show];
 [_sender removeFormPosts:_kanyangpost];
 }else if ([rslt isEqualToString:@"false"]) {
 UIAlertView *alertView = [[UIAlertView alloc]
 initWithTitle:@"失败"
 message:@"关闭操作失败"
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
 */
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _xiugaitap = YES;
    
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 5)]];
    
    self.tableView.allowsSelection = NO;
    
    //    UIBarButtonItem * xiugai = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStyleBordered target:self action:@selector(xiugai:)];
    //    self.navigationItem.rightBarButtonItem = xiugai;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)xiugaiziliao:(id)sender {
//    if (_xiugaitap) {
//        
//        _username.enabled = YES;
//        _userage.enabled = YES;
//        _useremail.enabled = YES;
//        _usersex.enabled = YES;
//        
//        [self.xiugaiziliao setTitle:@"提交资料" forState:UIControlStateNormal];
//        
//    }else{
//        
//        [self.xiugaiziliao setTitle:@"修改资料" forState:UIControlStateNormal];
//        _username.enabled = NO;
//        _userage.enabled = NO;
//        _useremail.enabled = NO;
//        _usersex.enabled = NO;
//        
//        [[TSAppDoNetAPIClient sharedClient] GET:@"FoxDelSampleItem.ashx" parameters:@{@"vipcode":_kanyangpost.Vipcode,@"itemcode":_kanyangpost.itemCode} success:^(NSURLSessionDataTask *task, id responseObject)
//         
//         
//         }
//         _xiugaitap = !_xiugaitap;
}
@end
