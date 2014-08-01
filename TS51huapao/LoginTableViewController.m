//
//  LoginTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "LoginNavigationController.h"
#import "LoginTableViewController.h"
#import "UIButton+Style.h"
#import "TSAppDoNetAPIClient.h"
#import "UIKit+AFNetworking.h"

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController

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
    [_outLogin LogInStyle];
    
    [TSUser sharedUser].LogStatus=@"N";
    
    [_vipcode becomeFirstResponder];
    _vipcode.text=[TSUser sharedUser].vipcode;
    [_regButton setTintColor:[UIColor colorWithRed:237/255.0 green:155/255.0 blue:67/255.0 alpha:1]];
}

-(void)regbuton
{
    
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
    return 3;
}

#pragma mark -UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:_vipcode]) {
        return [self validateNumber:string];
    }else{
        return YES;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:_vipcode]) {
        [_password becomeFirstResponder];
    }else if([textField isEqual:_password]){
        [self login:nil];
    }
    return YES;
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789-"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}


- (IBAction)login:(UIButton *)sender {
    [_vipcode resignFirstResponder];
    [_password resignFirstResponder];
    if (![self isValidateMobile:_vipcode.text]) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"你输入的是一个错误的手机号"
                                  delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:alertView
                                        repeats:NO];
        [alertView show];
        return;
    }
    if (_password.text.length<6) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"密码长度至少六位"
                                  delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:alertView
                                        repeats:NO];
        [alertView show];
        return;
    }
    
    [self checkUserPassWord:_vipcode.text toPassWord:_password.text];
}

-(void)checkUserPassWord:(NSString *)vipcode toPassWord:(NSString *)password
{
    NSURLSessionDataTask * task =[[TSAppDoNetAPIClient sharedClient] GET:@"FoxCheckLoginPassword.ashx" parameters:@{@"vipcode":vipcode,@"password":password} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            [self pushToMainView];
        }else if ([rslt isEqualToString:@"false"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"账号/密码错误"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}
-(void)pushToMainView{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Y" forKey:kMY_LOG_IN];
    [[NSUserDefaults standardUserDefaults]setObject:_vipcode.text forKey:kMY_USER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:_password.text forKey:kMY_USER_PASSWORD];
    [TSUser sharedUser].LogStatus=@"Y";
    [TSUser sharedUser].vipcode=_vipcode.text;
    [TSUser sharedUser].password=_password.text;
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"登录成功"
                              delegate:nil
                              cancelButtonTitle:@"关闭"
                              otherButtonTitles:nil, nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:alertView
                                    repeats:NO];
    [alertView show];
    
    //[[TSUser sharedUser] getMyVipInfo];
    NSURLSessionDataTask * task=[[TSUser sharedUser] getMyVipInfoBlock:^(NSError *error) {
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
            //如果是由会员退出页面到此页，登入成功后需要回调管理中心页面，刷新
            LoginNavigationController *NavigationController=(LoginNavigationController*)self.navigationController;
            [NavigationController refreshVipInfoWithCallback];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
    
}


@end
