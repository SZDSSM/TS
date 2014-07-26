//
//  TSMyInfoTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-25.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSMyInfoTableViewController.h"

@interface TSMyInfoTableViewController ()

@property (nonatomic, strong)NSMutableArray * itemArray;
@property (nonatomic, strong)NSDictionary * getDic;

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
    _itemArray = [@[@"用户名",@"姓名",@"年龄",@"邮箱"]mutableCopy];
//    [self.tableView setTableHeaderView:_sectionView];
    [self _initXiangXiLabel];

}

- (void)_initXiangXiLabel
{
    for (int j = 0; j < 2; j++) {
        for (int i = 0; i<2; i++) {
            UILabel * xiangxilabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 27, (ScreenWidth-25)/2, 15)];
            if (self.getDic != nil) {
                if (i == 0 && j == 0) {
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"DeliverPriceSUM"]];
                }else if (i == 1 && j == 0){
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"OpenDeliverPriceSUM"]];
                }else if (i == 0 && j == 1){
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"RecivePriceSUM"]];
                }else if (i == 1 && j == 1){
                    xiangxilabel.text = [NSString stringWithFormat:@"%@",[self.getDic objectForKey:@"OpenRecivePriceSUM"]];
                }
                xiangxilabel.textColor = [UIColor grayColor];
                xiangxilabel.font = [UIFont systemFontOfSize:14];
                xiangxilabel.textAlignment = NSTextAlignmentCenter;
                
            }
            [[self.view viewWithTag:100 - i + 2*j] addSubview:xiangxilabel];
            
        }
    }
    
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
    return [_itemArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = [_itemArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    
    return cell;
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
