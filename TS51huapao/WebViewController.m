//
//  WebViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-11.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "WebViewController.h"
#import "UIButton+Style.h"

@interface WebViewController ()

@property(nonatomic,strong)UIButton *button;
@end

@implementation WebViewController

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
    [self _initStatusBar];
    [self _initWebView];
    [self _initBackButton];
    
    [_webView.scrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication].keyWindow addSubview:_button];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_button removeFromSuperview];
}

- (void)_initStatusBar
{
    UIView * statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    [statusView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:statusView];
}

- (void)_initWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-40)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstr]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}

- (void)_initBackButton
{
    _button = [[UIButton alloc]init];
    [_button addTarget:self action:@selector(backButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [_button backStyle];
}

- (void)backButtonTap:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
