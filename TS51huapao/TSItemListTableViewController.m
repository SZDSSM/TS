//
//  TSItemListTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-13.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSItemListTableViewController.h"
#import "TSItemTableViewCell.h"
#import "TSItemListPost.h"
#import "UIKit+AFNetworking.h"

@interface TSItemListTableViewController ()

@property (strong, nonatomic) NSString * rankType;
@property (strong, nonatomic) NSArray * posts;

@end

@implementation TSItemListTableViewController

- (id)initWithRankType:(NSString *)rankType
{
    self = [super init];
    
    self.rankType = rankType;
    
    [self setHidesBottomBarWhenPushed:YES];
    return self;
}

- (void)viewDidLoad
{
    if ([self.rankType isEqualToString:@"S"]) {
        self.title = @"销售排行";

    }else if ([self.rankType isEqualToString:@"N"]) {
        self.title = @"新品排行";
        
    }else if ([self.rankType isEqualToString:@"J"]) {
        self.title = @"降价排行";
        
    }
    [super viewDidLoad];
    [self getData];
    UINib * nib = [UINib nibWithNibName:@"TSItemTableViewCell" bundle:nil];
    self.tableView.rowHeight = 65;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
    
   
}

- (void)getData
{
    NSURLSessionDataTask * task = [TSItemListPost globalTimeGetRecommendInfoWithRanktype:self.rankType Block:^(NSArray * posts, NSError *error) {
        //NSLog(@"error::%@",error);
        if (!error) {
            self.posts = posts;
            [self.tableView reloadData];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
        //[UIActivityIndicatorView set ]
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    if (nil == cell) {
        cell = [[TSItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.post = [self.posts objectAtIndex:indexPath.row];
//    cell.order.text =   [NSString stringWithFormat:@"%@",[indexPath.row]];
    cell.order.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    if (indexPath.row == 0) {
        cell.order.textColor = [UIColor redColor];
        cell.order.font = [UIFont italicSystemFontOfSize:35];

    }else if(indexPath.row == 1){
        cell.order.textColor = [UIColor redColor];
        cell.order.font = [UIFont italicSystemFontOfSize:30];
    }else if (indexPath.row == 2){
        cell.order.textColor = [UIColor redColor];
        cell.order.font = [UIFont italicSystemFontOfSize:25];
    }else{
        cell.order.textColor = [UIColor grayColor];
        cell.order.font = [UIFont italicSystemFontOfSize:17];
    }
    // Configure the cell...
    //cell.textLabel.text = _itemcode;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
