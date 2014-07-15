//
//  TSItemDetaillTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSItemDetaillTableViewController.h"
#import "TSItemDetailPost.h"
#import "UIImageView+AFNetworking.h"


@interface TSItemDetaillTableViewController ()

@property (strong, nonatomic)TSItemDetailPost * post;


@end

@implementation TSItemDetaillTableViewController

- (id)initWithItemCode:(NSString *)itemcode
{
    self = [super init];
    
    self.itemcode = itemcode;
    
    return self;
}

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)setPost:(TSItemDetailPost *)post
{
    _post = post;
    NSLog(@"post::%@",_post);
    self.ItemName.text = _post.ItemName;
    self.oldPrice.text = [NSString stringWithFormat:@"%@",_post.CostPrice];
    self.presentPrice.text = [NSString stringWithFormat:@"%@",_post.Price];
    self.priceNote.text = [NSString stringWithFormat:@"(%@)",_post.U_NEU_PriceNote];
    self.leftsum.text = [NSString stringWithFormat:@"%@",_post.stocksum];
    self.cuxiao.text = _post.U_NEU_cuxiao;
    [self.zhijiang setHidden:![_post.U_NEU_SaleType isEqualToString:@"直销"]];
    self.guige.text = _post.Spec;
    self.hanliang.text = [NSString stringWithFormat:@"%@",_post.U_Neu_Content];
    self.xianggui.text = _post.U_NEU_boxboard;
    self.maozhong.text = [NSString stringWithFormat:@"%@ 千克",_post.U_NEU_RoughWeight];
    _labarray = [NSMutableArray arrayWithCapacity:20];
    if ([_post.IsEnsure isEqualToString:@"Y"])
        [_labarray addObject:@"保险保障"];
    //                [(NSMutableArray *)(self.labarray) insertObject:@"1" atIndex:0];
    
    if ([_post.IsFreeShip isEqualToString:@"Y"])
        [self.labarray addObject:@"物流运输"];
    
    if ([_post.IsTrade isEqualToString:@"Y"])
        [self.labarray addObject:@"交易保障"];
    
    if ([_post.IsQaTest isEqualToString:@"Y"])
        [self.labarray addObject:@"质量检查"];
    
//    [self addlabel];
    [self addimage];
//    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLSessionDataTask * task = [TSItemDetailPost globalTimeGetRecommendInfoWithItemcode:self.itemcode Block:^(TSItemDetailPost *post, NSError *error) {
        NSLog(@"error::%@",error);
        if (!error) {
            self.post = post;
            
            
        }
    }];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    for (UILabel * lb in self.tabarray) {
//        lb.text = nil;
//    }
//}

- (void)addlabel
{
    for (UILabel * lb in self.tabarray)
    {
       static int i = 0;
        if (i > [self.labarray count]-1)
            lb.hidden = YES;
//        lb.text = [self.labarray objectAtIndex:i];
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



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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

- (IBAction)boFangAnNiu:(id)sender {
}
- (IBAction)guanzhu:(id)sender {
}
@end
