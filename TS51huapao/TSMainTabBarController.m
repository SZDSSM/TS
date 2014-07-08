//
//  TSMainTabBarController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-3-27.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSMainTabBarController.h"
@interface TSMainTabBarController ()

@end

@implementation TSMainTabBarController

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
    //设置推荐，资讯，我的选中状态时的图片
    UITabBarItem *BarItem=self.tabBar.items[0];
    [BarItem setSelectedImage:[UIImage imageNamed:@"recommend_selected"]];
    BarItem=self.tabBar.items[1];
    [BarItem setSelectedImage:[UIImage imageNamed:@"search_select"]];
    BarItem=self.tabBar.items[2];
    [BarItem setSelectedImage:[UIImage imageNamed:@"hy_select"]];
    BarItem=self.tabBar.items[3];
    [BarItem setSelectedImage:[UIImage imageNamed:@"Information_selected"]];
    BarItem=self.tabBar.items[4];
    [BarItem setSelectedImage:[UIImage imageNamed:@"me_select"]];
    //设置tabbar的上色颜色：橙红
    [self.tabBar setTintColor:[UIColor colorWithRed:1 green:69/255.0 blue:0 alpha:1]];
    


    //id a=[secondBarItem valueForKey:@"selectedimage"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"recommend" ofType:@"png"];
    //UIImage *image=[self reSizeImage: [UIImage imageNamed:@"recommend"]toSize:CGSizeMake(30,30)];
    //UIImage *image=[UIImage imageNamed:@"recommend"];
    //[firstBarItem initWithTitle:@"推荐" image:[image imageByScalingToSize:CGSizeMake(30,30)]selectedImage:secondBarItem.selectedImage];

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
