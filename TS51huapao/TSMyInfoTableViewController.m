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
#import "TSmimaxiugaiTableViewController.h"
#import "UIButton+Style.h"

@interface TSMyInfoTableViewController ()
{
    int keyBoardFlag;
}

@property (nonatomic, strong)NSMutableArray * itemArray;
@property (nonatomic, strong)NSDictionary * getDic;
@property (nonatomic)BOOL xiugaitap;
@property (nonatomic, strong)TSUser * user;
@property (nonatomic, strong)NSMutableDictionary * pushDic;
@property (nonatomic) BOOL change;

@end

@implementation TSMyInfoTableViewController


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
    
    
    [_xiugaiziliao LogInStyle];
    
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 5)]];
    
    _pushDic = [[NSDictionary dictionary]mutableCopy];
    
    
    self.tableView.allowsSelection = NO;
    
    _change = NO;
    
    _user = [TSUser sharedUser];
    
    [_pushDic setObject:_user.vipcode forKey:@"vipcode"];
    
    _username.enabled = NO;
    _userage.enabled = NO;
    _useremail.enabled = NO;
    _usersex.enabled = NO;
    
    _useremail.placeholder = @"暂无";
    _userage.placeholder = @"暂无";
    _username.placeholder = @"暂无";
    
    _username.delegate = self;
    _userage.delegate = self;
    _useremail.delegate = self;
    
    _username.text = _user.U_name;
    _userage.text = _user.U_age;
    _useremail.text = _user.U_email;
    
    if ([_user.U_gender isEqualToString:@"男"]) {
        _usersex.selectedSegmentIndex = 0;
    }else{
        _usersex.selectedSegmentIndex = 1;
    }
    keyBoardFlag = 1;
    
    
    UIBarButtonItem * xiugai = [[UIBarButtonItem alloc] initWithTitle:@"修改密码" style:UIBarButtonItemStyleBordered target:self action:@selector(xiugai)];
    self.navigationItem.rightBarButtonItem = xiugai;
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)xiugai
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TSmimaxiugaiTableViewController *viewController = [board instantiateViewControllerWithIdentifier:@"mimaxiugai"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(NSString *)removespace:(UITextField *)textfield
{
    
    return  [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (keyBoardFlag)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        
        self.view.frame=CGRectMake(self.view.frame.origin.x,-145, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        keyBoardFlag = 0;
    }
    
}


//隐藏输入键盘 (点击return)
-  (BOOL)textFieldShouldReturn:(UITextField  *)textField
{
	[textField  resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    keyBoardFlag = 1;
	return  YES;
}


- (IBAction)xiugaiziliao:(id)sender {
    if (_xiugaitap) {
        
        _username.enabled = YES;
        _userage.enabled = YES;
        _useremail.enabled = YES;
        _usersex.enabled = YES;
        
        [self.xiugaiziliao setTitle:@"提交资料" forState:UIControlStateNormal];
        
    }else{
        [self.view endEditing:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.view.frame=CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        keyBoardFlag = 1;
        [UIView commitAnimations];
        [self.xiugaiziliao setTitle:@"修改资料" forState:UIControlStateNormal];
        _username.enabled = NO;
        _userage.enabled = NO;
        _useremail.enabled = NO;
        _usersex.enabled = NO;
        
        if (![_user.U_name isEqualToString:[self removespace:_username]])
        {
            [_pushDic setObject:[self removespace:_username] forKey:@"username"];
            
            _change = YES;
        }else if (![_user.U_age isEqualToString:[self removespace:_userage]]){
            [_pushDic setObject:[self removespace:_userage] forKey:@"age"];
            _change = YES;
        }else if (![_user.U_email isEqualToString:[self removespace:_useremail]]){
            [_pushDic setObject:[self removespace:_useremail] forKey:@"email"];
            _change = YES;
        }
        
        if (_usersex.selectedSegmentIndex == 0 && ![_user.U_gender isEqualToString:@"男"]) {
            [_pushDic setObject:@"男" forKey:@"sex"];
            _change = YES;
        }else if (_usersex.selectedSegmentIndex == 1 && ![_user.U_gender isEqualToString:@"女"]){
            [_pushDic setObject:@"女" forKey:@"sex"];
            _change = YES;
        }
        
        if (_change) {
            [[TSAppDoNetAPIClient sharedClient] GET:@"FoxUpdateVipInfo.ashx" parameters:_pushDic success:^(NSURLSessionDataTask *task, id responseObject){
                NSString *rslt=[responseObject objectForKey:@"result"];
                if ([rslt isEqualToString:@"true"]) {
                    UIAlertView *alertView = [[UIAlertView alloc]
                                              initWithTitle:@"修改成功"
                                              message:@"修改用户资料成功"
                                              delegate:nil
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:nil, nil];
                    [alertView show];
                    [TSUser sharedUser].U_age = [self removespace:_userage];
                    [TSUser sharedUser].U_name = [self removespace:_username];
                    [TSUser sharedUser].U_email = [self removespace:_useremail];
                    if (_usersex.selectedSegmentIndex == 0) {
                        [TSUser sharedUser].U_gender = @"男";
                    }else{
                        [TSUser sharedUser].U_gender = @"女";
                    }
                    _change = NO;
                }else if ([rslt isEqualToString:@"false"]) {
                    UIAlertView *alertView = [[UIAlertView alloc]
                                              initWithTitle:@"修改失败"
                                              message:@"修改用户资料失败"
                                              delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    _change = YES;
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
        //
    }
    //
    _xiugaitap = !_xiugaitap;
}
@end
