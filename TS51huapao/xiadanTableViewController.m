//
//  xiadanTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "xiadanTableViewController.h"
#import "UIButton+Style.h"
#import "TSAppDoNetAPIClient.h"


@interface xiadanTableViewController ()
//callback
@property(weak,nonatomic)UIViewController *viewContr;
@property(nonatomic,copy)NSString *cPrice;
@property(nonatomic)SEL func_selector;
@end

@implementation xiadanTableViewController

-(void)xiadanAtTarget:(UIViewController *)target action:(SEL)action
{
    _viewContr=target;
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

-(void)backbutton:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [_viewContr viewWillAppear:NO];
    }];
}
-(void)changeInfo:(UIBarButtonItem *)sender{
    [_qty resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"删除这条下单记录"
                                  otherButtonTitles:@"更改下单数量",@"继续添加",nil];
    actionSheet.actionSheetStyle =  UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)]];
    
    self.title=@"下单";
    
    _qty.delegate=self;
    //leftbarbutton
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle: @"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backbutton:)];//く返回
    [backItem setTintColor:[UIColor lightGrayColor]];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [_xiadan LogInStyle];
    
    
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 1.0f;
    [self.shadowView layer].borderColor = [[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:240.0/255.0] CGColor];
    [self.shadowView layer].borderWidth = 0.2;
    
    [self.photo1 setImageWithURL:[NSURL URLWithString:_post.U_Photo1] placeholderImage:[UIImage imageNamed:@"noImage"]];
    
    self.itemname.text=_post.ItemName;
    _spec.text=_post.Spec;
    
    NSString *cp=[[NSString alloc]init];
    if ([_post.U_NEU_SaleType isEqualToString:@"直销"]) {
        if (_post.CostPrice.floatValue>0 &&[TSUser sharedUser].USERTYPE==TSUnionClient) {
            cp=_post.CostPrice;
        }else{
            cp=_post.Price;
        }
    }else{
        cp=_post.Price;
    }
    _cPrice=cp;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[cp stringByAppendingString:@"元/每箱"]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,[cp length])];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20.0] range:NSMakeRange(0,[cp length])];
    //_labelCurrentPrice.text=cp;
    _price.attributedText=str;
    if ([_post.orderQuantity hasPrefix:@"0"]) {
        _orderQty.text=@"";
        _labelYiXiaDan.hidden=YES;
    }else{
        _orderQty.text=[_post.orderQuantity stringByAppendingString:@"箱"];
        _labelYiXiaDan.hidden=NO;
        //rightbarbutton
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(changeInfo:)];
        [item setTintColor:[UIColor grayColor]];
        self.navigationItem.rightBarButtonItem = item;
    }

    _stock.text=[_post.stocksum stringByAppendingString:@"箱"];
    
    _labelQty.text=@"数量";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//// -------------------------------------------------------------------------------
////	scrollViewDidEndDecelerating:
//// -------------------------------------------------------------------------------

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView]) {
        if ([_qty isFirstResponder]) {
            [_qty resignFirstResponder];
        }
    }
}


#pragma  mark-- 实现UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self deleteOrderItem];
    }else if(buttonIndex==1){
        _labelQty.text=@"数量更改为";
        [_xiadan setTitle:@"提交更改" forState:UIControlStateNormal];
        [_qty becomeFirstResponder];
    }else if(buttonIndex==2){
        _labelQty.text=@"数量";
        [_xiadan setTitle:@"确认下单" forState:UIControlStateNormal];
        [_qty becomeFirstResponder];
    }
}
#pragma  mark-- 实现UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([alertView.title isEqual:@"删除"]) {
        if (buttonIndex==0) {
            [self dismissViewControllerAnimated:YES completion:^{
                [_viewContr viewWillAppear:NO];
                [_post setOrderQuantity:@"0"];
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if( [_viewContr respondsToSelector:_func_selector])
                {
                    [_viewContr performSelector:_func_selector];
                }
            }];
        }
    }
    else if ([alertView.title isEqual:@"修改"]) {
        if (buttonIndex==0) {
            [self dismissViewControllerAnimated:YES completion:^{
                [_viewContr viewWillAppear:NO];
                [_post setOrderQuantity:_qty.text];
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if( [_viewContr respondsToSelector:_func_selector])
                {
                    [_viewContr performSelector:_func_selector];
                }
            }];
        }
    }
    else if ([alertView.title isEqual:@"下单"]) {
        if (buttonIndex==0) {
            [self dismissViewControllerAnimated:YES completion:^{
                [_viewContr viewWillAppear:NO];
                int a=[_post.orderQuantity intValue];
                int b=[_qty.text intValue];
                NSString *str=[NSString stringWithFormat:@"%d",(a+b)];
                [_post setOrderQuantity:str];
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if( [_viewContr respondsToSelector:_func_selector])
                {
                    [_viewContr performSelector:_func_selector];
                }
            }];
        }
    }
}
#pragma mark -UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:_qty]) {
        if (range.location==0) {
            return [self validateNumber:string in:@"123456789"];
        }else{
            return [self validateNumber:string in:@"0123456789"];
        }
        
    }else{
        return YES;
    }
}

- (BOOL)validateNumber:(NSString*)number in:(NSString *)inString {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:inString];
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

-(void)deleteOrderItem
{
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxPlaceAnOrder.ashx" parameters:@{@"type":@"D",@"vipcode":[TSUser sharedUser].vipcode,@"itemcode":_post.ItemCode} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"删除"
                                      message:@"成功删除"
                                      delegate:self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }else  {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"删除操作失败"
                                      delegate:nil
                                      cancelButtonTitle:@"确定"
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
}


///-----数据操作
-(void)updateOrderItem
{
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxPlaceAnOrder.ashx" parameters:@{@"type":@"U",@"vipcode":[TSUser sharedUser].vipcode,@"itemcode":_post.ItemCode,@"Quantity":_qty.text,@"price":_cPrice} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"修改"
                                      message:@"意向订单修改成功"
                                      delegate:self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"意向订单修改失败"
                                      delegate:nil
                                      cancelButtonTitle:@"确定"
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

}
-(void)AddOrderItem
{
    [[TSAppDoNetAPIClient sharedClient] GET:@"FoxPlaceAnOrder.ashx" parameters:@{@"type":@"A",@"vipcode":[TSUser sharedUser].vipcode,@"itemcode":_post.ItemCode,@"Quantity":_qty.text,@"price":_cPrice} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *rslt=[responseObject objectForKey:@"result"];
        if ([rslt isEqualToString:@"true"]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"下单"
                                      message:@"意向订单提交成功"
                                      delegate:self
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"失败"
                                      message:@"意向订单提交失败"
                                      delegate:nil
                                      cancelButtonTitle:@"确定"
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
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}


- (IBAction)xiadanClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"确认下单"]) {
        if ([_qty.text length]>0){
            [self AddOrderItem];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"数量不能为空"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else if ([sender.titleLabel.text isEqualToString:@"提交更改"]) {
        if ([_qty.text length]>0){
            [self updateOrderItem];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"数量不能为空"
                                      delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}
- (IBAction)callClick:(UIButton *)sender {
    NSString *phonenumber=@"4006751518";
    NSString *call=[NSString stringWithFormat:@"telprompt://%@",phonenumber];//telprompt 打电话前先弹框  是否打电话 然后打完电话之后回到程序中,可能不合法无法通过审核
    NSURL *callURL=[NSURL URLWithString:call];
    [[UIApplication sharedApplication] openURL:callURL];
}
@end
