//
//  FifthNavigationController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-31.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "FifthNavigationController.h"


@interface FifthNavigationController ()

@end

@implementation FifthNavigationController


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
    
//    if ([TSUser sharedUser].USERTYPE==TSManager) {
//        TSglyTableViewController *ViewContr = [[TSglyTableViewController alloc]init];
//        id nav=[self initWithRootViewController:ViewContr];
//    }else if ([TSUser sharedUser].USERTYPE==TSVender) {
//        TSgysTableViewController *ViewContr = [[TSgysTableViewController alloc]init];
//        [self initWithRootViewController:ViewContr];
//    }else if ([TSUser sharedUser].USERTYPE==TSCommonClient ||[TSUser sharedUser].USERTYPE==TSUnionClient) {
//        TSMyFirstTableViewController *ViewContr = [[TSMyFirstTableViewController alloc]init];
//        [self initWithRootViewController:ViewContr];
//    }
    
    
    //[self initWithRootViewController:glyView];
    // Do any additional setup after loading the view.
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
