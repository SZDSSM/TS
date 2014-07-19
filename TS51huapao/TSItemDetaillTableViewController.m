//
//  TSItemDetaillTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//
#import "WebViewController.h"

#import "TSItemDetaillTableViewController.h"
#import "TSItemDetailPost.h"
//#import "UIImageView+AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface TSItemDetaillTableViewController ()

@property (strong, nonatomic)TSItemDetailPost * post;


@end

@implementation TSItemDetaillTableViewController


- (void)setPost:(TSItemDetailPost *)post
{
    _post = post;
    NSLog(@"post::%@",_post);
    self.ItemName.text = [NSString stringWithFormat:@"%@",_post.ItemName];
    self.oldPrice.text = [NSString stringWithFormat:@"%@",_post.CostPrice];
    self.presentPrice.text = [NSString stringWithFormat:@"%@",_post.Price];
    if ([_post.U_NEU_PriceNote isEqualToString:@""]) {
        self.priceNote.text = @"";
    }else{
        self.priceNote.text = [NSString stringWithFormat:@"(%@)",_post.U_NEU_PriceNote];
    }
    self.leftsum.text = [NSString stringWithFormat:@"%@",_post.stocksum];
    self.cuxiao.text = [NSString stringWithFormat:@"%@",_post.U_NEU_cuxiao];
    
    if ([_post.U_NEU_Rebate floatValue]>0){
        [self.fanli setHidden:NO];
    }else{
        [self.fanli setHidden:YES];
    }
    
    if ([_post.U_NEU_SaleType isEqualToString:@"直销"]){
        [self.zhijiang setHidden:NO];
    }else{
        [self.zhijiang setHidden:YES];
    }
    
    
    self.guige.text = [NSString stringWithFormat:@"%@",_post.Spec];
    self.hanliang.text = [NSString stringWithFormat:@"%@",_post.U_Neu_Content];
    self.xianggui.text = [NSString stringWithFormat:@"%@",_post.U_NEU_boxboard];
    self.maozhong.text = [NSString stringWithFormat:@"%@ 千克",_post.U_NEU_RoughWeight];
    _labarray = [NSMutableArray arrayWithCapacity:20];
    if ([_post.IsEnsure isEqualToString:@"Y"])
        [_labarray addObject:@"保险保障"];
    
    if ([_post.IsFreeShip isEqualToString:@"Y"])
        [self.labarray addObject:@"物流运输"];
    
    if ([_post.IsTrade isEqualToString:@"Y"])
        [self.labarray addObject:@"交易保障"];
    
    if ([_post.IsQaTest isEqualToString:@"Y"])
        [self.labarray addObject:@"质量检查"];
    
    if (![_post.UMTVURL hasPrefix:@"http"]) {
        _mtvButton.hidden=YES;
    }else{
        _mtvButton.hidden=NO;
    }
    
    [self addlabel];
    [self addimage];
//    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLSessionDataTask * task = [TSItemDetailPost globalTimeGetRecommendInfoWithItemcode:self.itemcode Block:^(TSItemDetailPost *post, NSError *error) {
        //NSLog(@"error::%@",error);
        if (!error) {
            self.post = post;
            }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
    
}

- (void)addlabel
{
    int i=1;
    for (UILabel * lb in self.tabarray)
    {
        if (i > [self.labarray count]){
            lb.hidden = YES;
//            lb.text = [self.labarray objectAtIndex:i];
        }
        else{
            lb.hidden = NO;
            lb.text = [self.labarray objectAtIndex:i-1];
            lb.layer.borderWidth = 1;
            lb.layer.masksToBounds = YES;
            lb.layer.borderColor = [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
            
        }
        i ++;
    }
}

- (void)addimage
{
    [self.Productimage setImageWithURL:[NSURL URLWithString:_post.U_Photo2] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source




/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = [[NSString alloc]init];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    identify = @"FirstCell";
                    break;
                case 1:
                    identify = @"SecondCell";
                    break;
                case 2:
                case 4:
                case 6:
                    identify = @"DividCell";
                    break;
                case 3:
                    identify = @"ForthCell";
                    break;
                case 5:
                    identify = @"SixthCell";
                    break;
                case 7:
                    identify = @"eighthCell";
                    break;                    
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    identify = @"NinthCell";
                    break;
                case 1:
                    identify = @"TenthCell";
                    break;
                case 2:
                    identify = @"DividCell";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    identify = @"TwelvethCell";
                    break;
                case 1:
                    identify = @"ThirteenthCell";
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    // Configure the cell...
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)boFangAnNiu:(id)sender {
//}
//- (IBAction)guanzhu:(id)sender {
//}

- (IBAction)guanzhu:(id)sender{
    
}

- (IBAction)boFangAnNiu:(id)sender{
    
    WebViewController *_webVC = [[WebViewController alloc] init];
    _webVC.hidesBottomBarWhenPushed = YES;
    //    [_logsInfo_vc setInfo:content];
    [_webVC setUrlstr:_post.UMTVURL];
    [self.navigationController pushViewController:_webVC animated:YES];
}
@end
