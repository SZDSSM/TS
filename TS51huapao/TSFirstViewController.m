//
//  TSFirstViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-3-27.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSFirstViewController.h"
#import "UIButton+Style.h"
#import "MJRefresh.h"
#import "UIView+FoxExtras.h"
#import "AFNetworking.h"
#import "TSRcmd.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+URLEncoding.h"
#import "TSItemListTableViewController.h"
#import "TSAppDoNetAPIClient.h"
#import "TSrecommendPost.h"
#import "ItemDetailTableViewController.h"
#import "FristSearchTableViewController.h"
#import "TSRecommentTableViewController.h"
#import "TSSecondResultTableViewController.h"


#import "LoginNavigationController.h"

//static NSString *  const touchurl = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetRecommendList.ashx";

@interface TSFirstViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *product1;
@property (weak, nonatomic) IBOutlet UIImageView *product2;
@property (weak, nonatomic) IBOutlet UIImageView *product3;
@property (weak, nonatomic) IBOutlet UIImageView *subject1;
@property (weak, nonatomic) IBOutlet UIImageView *subject2;
@property (weak, nonatomic) IBOutlet UIImageView *subject3;

//searchbar
@property(strong,nonatomic) FristSearchTableViewController *searchbarControl;

@end

@implementation TSFirstViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

//- (UIImageView *)imageView:(UIImageView * )imageView addSelector:(SEL)selector
//{
//    imageView.userInteractionEnabled = YES;
//    [imageView addGestureRecognizer:[[UIGestureRecognizer alloc]initWithTarget:self action:selector]];
//    return imageView;
//}

- (void)imageSet
{
//    self.product1 = [self imageview:(NSString *)[[self.getDic objectForKey:@"prdctRcmd1"]objectForKey:@"imageurl"]];
    [self imageview:self.product1 setImageWithURL:self.prdctRcmd1.imageURL];
    [self imageview:self.product2 setImageWithURL:self.prdctRcmd2.imageURL];
    [self imageview:self.product3 setImageWithURL:self.prdctRcmd3.imageURL];
    
    //[_product1 setImageWithURL:[NSURL URLWithString: _prdctRcmd1.imageURL] placeholderImage:nil];
    //[_product2 setImageWithURL:[NSURL URLWithString: _prdctRcmd2.imageURL] placeholderImage:nil];
    //[_product3 setImageWithURL:[NSURL URLWithString: _prdctRcmd3.imageURL] placeholderImage:nil];
    
    //[self.subject1 setImageWithURL:[NSURL URLWithString: self.subjctRcmd1.imageURL] placeholderImage:nil];

    //[self.subject1 setImageWithURL:[NSURL URLWithString:self.prdctRcmd1.imageURL] placeholderImage:[UIImage imageNamed:@""]];
    [self imageview:self.subject1 setImageWithURL:self.subjctRcmd1.imageURL];
    [self imageview:self.subject2 setImageWithURL:self.subjctRcmd2.imageURL];
    [self imageview:self.subject3 setImageWithURL:self.subjctRcmd3.imageURL];

    
}

-(void)viewWillAppear:(BOOL)animated
{

}
-(void)checkVipInfo
{
    if (![[TSUser sharedUser].LogStatus isEqualToString:@"Y"]) {
        UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginNavigationController *loginNavigation=[board instantiateViewControllerWithIdentifier:@"LoginNavigation"];
        [self presentViewController:loginNavigation animated:NO completion:nil];
    }else{
       // NSString *pas=[TSUser sharedUser].password;
        //[TSUser sharedUser].password=@"1234567";
        
        [[TSAppDoNetAPIClient sharedClient] GET:@"FoxCheckLoginPassword.ashx" parameters:@{@"vipcode":[TSUser sharedUser].vipcode,@"password":[TSUser sharedUser].password} success:^(NSURLSessionDataTask *task, id responseObject) {
                NSString *rslt=[responseObject objectForKey:@"result"];
                if ([rslt isEqualToString:@"false"]) {
                    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    LoginNavigationController *loginNavigation=[board instantiateViewControllerWithIdentifier:@"LoginNavigation"];
                    [self presentViewController:loginNavigation animated:NO completion:nil];
                }else{
                    [[TSUser sharedUser] getMyVipInfoBlock:nil];
//                    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
                }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _prdctRcmd1 = [[TSRcmd alloc]init];
    _prdctRcmd2 = [[TSRcmd alloc]init];
    _prdctRcmd3 = [[TSRcmd alloc]init];
    _subjctRcmd1 = [[TSRcmd alloc]init];
    _subjctRcmd2 = [[TSRcmd alloc]init];
    _subjctRcmd3 = [[TSRcmd alloc]init];
    
    [self checkVipInfo];
    
    //1.初始化刷新
    [self setupRefresh];
    //2.初始化搜索框
    _searchbarControl=[[FristSearchTableViewController alloc]initWithSearchesKey:@"ItemSearchesKey" SearchPlaceholder:NSLocalizedString(@"itemsearchplaceholder", @"") target:self action:@selector(searchButtonClick:)];
    
    
    
}
-(void)searchButtonClick:(NSString *)searchText
{
    TSSecondResultTableViewController * viewController = [[TSSecondResultTableViewController alloc] init];
    viewController.searchtext = searchText;
    viewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)gettouch
{
   
        NSString * touchurl = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetRecommendList.ashx";

        NSString *URLTmp1 = [touchurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
        touchurl = URLTmp1;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: touchurl]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"Success: %@", operation.responseString);
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
                self.getDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error];
//                self.array = [dic objectForKey:@"NewsDataIOS"];
//                NSLog(@"dic:::%@",self.getDic);
                self.labelarray = [self.getDic objectForKey:@"TnavigationLabels"];
//                NSLog(@"arr:::%@",self.labelarray);
                [self addLableButton];
                self.telephoneNumeber = [self.getDic objectForKey:@"TservicePhone"];
                NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
                [userdef setObject:self.telephoneNumeber forKey:Tele_Key];
                [userdef synchronize];
                
                [self.prdctRcmd1 setRcmd:self.getDic withKey:@"prdctRcmd1"];
                [self.prdctRcmd2 setRcmd:self.getDic withKey:@"prdctRcmd2"];
                [self.prdctRcmd3 setRcmd:self.getDic withKey:@"prdctRcmd3"];
                [self.subjctRcmd1 setRcmd:self.getDic withKey:@"subjctRcmd1"];
                [self.subjctRcmd2 setRcmd:self.getDic withKey:@"subjctRcmd2"];
                [self.subjctRcmd3 setRcmd:self.getDic withKey:@"subjctRcmd3"];
//                NSLog(@"ooooo:%@",self.subjctRcmd3);
                [self imageSet];
                [self.tableView reloadData];
                
            }else if(nil == resData){
                UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [AlertView1 show];
               
            }
            
            [self.tableView headerEndRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Failure: %@", error);
            UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [AlertView1 show];
            [self.tableView headerEndRefreshing];
        }];
        [operation start];
//        NSLog(@"%lu",(unsigned long)[self.array count]);
    
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView headerBeginRefreshing];
    // 2.添加tableFooterView 服务电话
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 110.0f)];
    self.tableView.tableFooterView =[view addRecommndFooterView:self];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self gettouch];
}

- (void)imageview:(UIImageView *)imageView setImageWithURL:(NSString * )url
{
   
    
    __weak UIImageView *_imageView = imageView;
    
//    NSLog(@"url::::%@",url);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[url URLEncodedString]
]]  placeholderImage:[UIImage imageNamed:@""]
        success:^(NSURLRequest *request,NSHTTPURLResponse *response, UIImage *image) {
            _imageView.image = image;
            [_imageView setNeedsDisplay];
            _imageView.userInteractionEnabled = YES;
            [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)]];
        }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse*response, NSError *error){    NSLog(@"error::%@",error);                        }];
//    return imageView;
}

- (void)imageViewTap:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.view.tag == 101) {
        [self pushtoItemDetailView:_prdctRcmd1.itemCode];
        
    }else if (recognizer.view.tag == 102){
        [self pushtoItemDetailView:_prdctRcmd2.itemCode];

    }else if (recognizer.view.tag == 103){
        [self pushtoItemDetailView:_prdctRcmd3.itemCode];

    }else if (recognizer.view.tag == 201){
        [self toItemlist:_subjctRcmd1.itemCode];

    }else if (recognizer.view.tag == 202){
        [self toItemlist:_subjctRcmd2.itemCode];

    }else if (recognizer.view.tag == 203){
        [self toItemlist:_subjctRcmd3.itemCode];

    }else{
    }
}

- (void)addLableButton
{
       for (int i = 0; i < [self.labelarray count]; i ++)
    {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(16+(i%3)*(87+14), 13+(i/3)*(30+8), 87, 30)];
        [button setTitle:[self.labelarray objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [button mainProductStyle];
        //UIView *view=self.cotentview;
        [self.cotentview addSubview:button];
    }
    
}

- (void)buttonTap:(UIButton *)button
{
    [self toItemlist:button.titleLabel.text];
//    [button.superview.frame.size
}
-(void)toItemlist:(NSString *)name
{
    TSRecommentTableViewController * recommentTable = [[TSRecommentTableViewController alloc]initWithRecomment:name];
    [self.navigationController pushViewController:recommentTable animated:YES];
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
    return 10;
}

#pragma mark - Action
-(void)callButton:(id)sender
{
    NSString *phonenumber=@"4006751518";
    NSString *call=[NSString stringWithFormat:@"telprompt://%@",phonenumber];//telprompt 打电话前先弹框  是否打电话 然后打完电话之后回到程序中,可能不合法无法通过审核
    NSURL *callURL=[NSURL URLWithString:call];
    [[UIApplication sharedApplication] openURL:callURL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//     if(indexPath.row != 9)
//        
//          return [tableView cellForRowAtIndexPath:indexPath].frame.size.height;
//      else
//          return 200;
    switch (indexPath.row) {
        case 0:
            return 79;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 115;
            break;
        case 4:
            return 44;
            break;
        case 5:
            return 163;
            break;
        case 6:
            return 44;
            break;
        case 7:
            return 1;
            break;
        case 8:
            if ([self.labelarray count]%3==0) {
                return ([self.labelarray count]/3)*45;
            }else{
                return ([self.labelarray count]/3+1)*45;
            }
            break;
        case 9:
            return 1;
            break;
        
        default:
            return 1;
            break;
    }
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
// {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
//     if ([segue.identifier isEqualToString:@"imageViewToItemDetail"]) {
//         TSItemDetaillTableViewController * tsitemde = segue.destinationViewController;
//         tsitemde.itemcode =sender;
//     }
//}

-(void)pushtoItemDetailView:(NSString *)itemcode
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailTableViewController *itemdetail = [board instantiateViewControllerWithIdentifier:@"tsItemdetail"];
    itemdetail.itemcode=itemcode;
    [self.navigationController pushViewController:itemdetail animated:YES];
}
- (IBAction)xiaoshoupaihang:(id)sender {
    
    TSItemListTableViewController * xiaoshou = [[TSItemListTableViewController alloc]initWithRankType:@"S"];
    [self.navigationController pushViewController:xiaoshou animated:YES];
    
}

- (IBAction)xinpinpaihang:(id)sender {
    
    TSItemListTableViewController * xinpin = [[TSItemListTableViewController alloc]initWithRankType:@"N"];
    [self.navigationController pushViewController:xinpin animated:YES];
}

- (IBAction)jiangjiapaihang:(id)sender {
    
    TSItemListTableViewController * jiangjia = [[TSItemListTableViewController alloc]initWithRankType:@"J"];
    [self.navigationController pushViewController:jiangjia animated:YES];
}
@end
