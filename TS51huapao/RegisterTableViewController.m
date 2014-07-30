//
//  RegisterTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "UIButton+Style.h"
#import "TSAppDoNetAPIClient.h"
#import "UIKit+AFNetworking.h"

@interface RegisterTableViewController ()

@property(nonatomic,weak)NSString *vipcode;
@property(nonatomic,weak)NSString *isAPLing;

@end

@implementation RegisterTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    _isAPLing=[[NSUserDefaults standardUserDefaults] objectForKey:@"APL-KEY"];
//    
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_regt LogInStyle];
    [_outAPLagain dangerStyle];
    [_updateAPlinfo infoStyle];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle: @"く返回" style:UIBarButtonItemStylePlain target:self action:@selector(backbutton:)];
    [backItem setTintColor:[UIColor lightGrayColor]];
    self.navigationItem.leftBarButtonItem=backItem;
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor lightGrayColor]];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"APL-INAPLING"] isEqualToString:@"Y"]) {
        _phoneNumber.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"APL-VIPCODE"];
        _ConnactName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"APL-CONNACT"];
        _CardName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"APL-CARDNAME"];
        _phoneNumber.enabled=NO;
        _ConnactName.enabled=NO;
        _CardName.enabled=NO;
        _promptInfo.hidden=NO;
        _outAPLagain.hidden=NO;
        _updateAPlinfo.hidden=NO;
        _regt.hidden=YES;
    }else{
        _phoneNumber.enabled=YES;
        _ConnactName.enabled=YES;
        _CardName.enabled=YES;
        _promptInfo.hidden=YES;
        _outAPLagain.hidden=YES;
        _updateAPlinfo.hidden=YES;
        _regt.hidden=NO;
        [_phoneNumber becomeFirstResponder];
    }

    
}
-(void)backbutton:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
    return 5;
}

#pragma mark -UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:_phoneNumber]) {
        return [self validateNumber:string];
    }else{
        return YES;
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:_phoneNumber]) {
        [_ConnactName becomeFirstResponder];
    }else if([textField isEqual:_ConnactName]){
        [_CardName becomeFirstResponder];
    }else if([textField isEqual:_CardName]){
        [self registerClick:nil];
    }
    return YES;
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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

- (IBAction)registerClick:(UIButton *)sender {
    
    [_phoneNumber resignFirstResponder];
    [_ConnactName resignFirstResponder];
    [_CardName resignFirstResponder];
    if (![self isValidateMobile:_phoneNumber.text]) {
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
    if (_ConnactName.text.length<3) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"请输入正确的称呼"
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
    if (_CardName.text.length<3) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"请输入正确的企业名称"
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
    if ([sender.titleLabel.text isEqualToString:@"注册"]) {
        NSURLSessionDataTask * task =[[TSAppDoNetAPIClient sharedClient] GET:@"FoxRegisterAnVipApl.ashx" parameters:@{@"U_phone":_phoneNumber.text,@"U_cntct":_ConnactName.text,@"U_cardname":_CardName.text} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *rslt=[responseObject objectForKey:@"result"];
            if ([rslt isEqualToString:@"true"]) {
                [self pushToMainView:@"注册申请提交成功"];
            }else if ([rslt isEqualToString:@"false"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"注册申请提交失败"
                                          delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil, nil];
                [alertView show];
            }else if ([rslt isEqualToString:@"exists in applying"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"该手机号已在注册申请队列中"
                                          delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil, nil];
                [alertView show];
            }else if ([rslt isEqualToString:@"exsits in VIP"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"该手机号已是vip"
                                          delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil, nil];
                [alertView show];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"网络响应失败"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }];
        [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    }else{
        NSURLSessionDataTask * task =[[TSAppDoNetAPIClient sharedClient] GET:@"FoxUpdateAnAppliction.ashx" parameters:@{@"vipcode":[[NSUserDefaults standardUserDefaults] objectForKey:@"APL-VIPCODE"],@"U_phone":_phoneNumber.text,@"U_cntct":_ConnactName.text,@"U_cardname":_CardName.text} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *rslt=[responseObject objectForKey:@"result"];
            if ([rslt isEqualToString:@"true"]) {
                _promptInfo.text=@"你的申请正在处理中，信息如下:";
                [self pushToMainView:@"新信息修改成功"];
            }else if ([rslt isEqualToString:@"false"]) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"修改信息失败"
                                          delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil, nil];
                [alertView show];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"网络响应失败"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }];
        [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    }
    
}
-(void)pushToMainView:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"关闭"
                              otherButtonTitles:nil, nil];
    [alertView show];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"Y" forKey:@"APL-INAPLING"];
    [[NSUserDefaults standardUserDefaults]setObject:_phoneNumber.text forKey:@"APL-VIPCODE"];
    [[NSUserDefaults standardUserDefaults]setObject:_ConnactName.text forKey:@"APL-CONNACT"];
    [[NSUserDefaults standardUserDefaults]setObject:_CardName.text forKey:@"APL-CARDNAME"];
    
    _phoneNumber.enabled=NO;
    _ConnactName.enabled=NO;
    _CardName.enabled=NO;
    _promptInfo.hidden=NO;
    _outAPLagain.hidden=NO;
    _updateAPlinfo.hidden=NO;
    _regt.hidden=YES;
    [self.tableView reloadData];
}
- (IBAction)serviceInfo:(UIButton *)sender {
}
- (IBAction)actionUpadteAPL:(UIButton *)sender {
    _promptInfo.text=@"确认修改你的信息后,请提交!";
    _phoneNumber.enabled=YES;
    _ConnactName.enabled=YES;
    _CardName.enabled=YES;
    _outAPLagain.hidden=YES;
    _updateAPlinfo.hidden=YES;
    
    [_regt setTitle:@"提交修改" forState:UIControlStateNormal];
    _regt.hidden=NO;
    [_phoneNumber becomeFirstResponder];
}

- (IBAction)actionAPLagin:(id)sender {
    [[NSUserDefaults standardUserDefaults]setObject:@"N" forKey:@"APL-INAPLING"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"APL-VIPCODE"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"APL-CONNACT"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"APL-CARDNAME"];
    _phoneNumber.text=@"";
    _ConnactName.text=@"";
    _CardName.text=@"";
    _phoneNumber.enabled=YES;
    _ConnactName.enabled=YES;
    _CardName.enabled=YES;
    _promptInfo.hidden=YES;
    _outAPLagain.hidden=YES;
    _updateAPlinfo.hidden=YES;
    [_regt setTitle:@"注册" forState:UIControlStateNormal];
    _regt.hidden=NO;
    [_phoneNumber becomeFirstResponder];
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"APL-INAPLING"] isEqualToString:@"Y"]) {
            return 40;
        }else{
            return 0;
        }
    }else if (indexPath.row==4) {
        return 150;
    }
    return 32;
}
@end
