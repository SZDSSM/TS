//
//  LoginTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *vipcode;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *outLogin;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *regButton;

@end
