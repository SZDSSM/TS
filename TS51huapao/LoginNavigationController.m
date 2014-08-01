//
//  LoginNavigationController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-29.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "LoginNavigationController.h"

@interface LoginNavigationController ()

@property (nonatomic, copy) void (^beginRefreshingVipInfoCallback)();

@end

@implementation LoginNavigationController

- (void)addVipInfoRefreshWithCallback:(void (^)())callback{
    self.beginRefreshingVipInfoCallback=callback;
}
-(void)refreshVipInfoWithCallback
{
    if (self.beginRefreshingVipInfoCallback) {
        self.beginRefreshingVipInfoCallback();
    }
}

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
