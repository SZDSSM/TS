//
//  TSMyInfoTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-25.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSMyInfoTableViewController : UITableViewController

@property (nonatomic, strong)UIView * sectionView;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UISegmentedControl *usersex;
@property (weak, nonatomic) IBOutlet UITextField *userage;
@property (weak, nonatomic) IBOutlet UITextField *useremail;
@property (weak, nonatomic) IBOutlet UIButton *xiugaiziliao;

- (IBAction)xiugaiziliao:(id)sender;

@end
