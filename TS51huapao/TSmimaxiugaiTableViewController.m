//
//  TSmimaxiugaiTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-8-1.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSmimaxiugaiTableViewController.h"
#import "TSUser.h"
#import "TSAppDoNetAPIClient.h"
#import "UIButton+Style.h"
@interface TSmimaxiugaiTableViewController ()

@end

@implementation TSmimaxiugaiTableViewController

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
    
    [_tijiao LogInStyle];
    self.title = @"密码修改";
    
    _oldsec.delegate = self;
    _newsec.delegate = self;
    _newsecagain.delegate = self;
    
    _oldsec.secureTextEntry = YES;
    _newsec.secureTextEntry = YES;
    _newsecagain.secureTextEntry = YES;
    
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 5)]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (BOOL)textFieldShouldReturn:(UITextField  *)textField
{
	[textField  resignFirstResponder];
    return  YES;
}

-(NSString *)removespace:(UITextField *)textfield
{
    
    return  [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tijiao:(id)sender {
    
    [self.view endEditing:YES];

    if ([[TSUser sharedUser].password isEqualToString:[self removespace:_oldsec]]) {
        if ([[self removespace:_newsec]isEqualToString:[self removespace:_newsecagain]]) {
            [[TSAppDoNetAPIClient sharedClient] GET:@"FoxUpdateVipInfo.ashx" parameters:@{@"vipcode":[TSUser sharedUser].vipcode,@"password": [self removespace:_newsec]} success:^(NSURLSessionDataTask *task, id responseObject){
                NSString *rslt=[responseObject objectForKey:@"result"];
                if ([rslt isEqualToString:@"true"]) {
                    UIAlertView *alertView = [[UIAlertView alloc]
                                              initWithTitle:@"修改成功"
                                              message:@"密码修改成功"
                                              delegate:nil
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:nil, nil];
                    alertView.delegate =self;
                    
                    [alertView show];
                    [TSUser sharedUser].password = [self removespace:_newsec];
                    
                    }else if ([rslt isEqualToString:@"false"]) {
                    UIAlertView *alertView = [[UIAlertView alloc]
                                              initWithTitle:@"修改失败"
                                              message:@"修改用户密码失败"
                                              delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
                    
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
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"两次输入新密码不一致"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"用户密码输入错误,请重新输入旧密码"
                                  delegate:nil
                                  cancelButtonTitle:@"关闭"
                                  otherButtonTitles:nil, nil];
            [alertView show];
    }
}
@end
