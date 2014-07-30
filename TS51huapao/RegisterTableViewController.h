//
//  RegisterTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-28.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTableViewController : UITableViewController<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *ConnactName;
@property (weak, nonatomic) IBOutlet UITextField *CardName;
@property (weak, nonatomic) IBOutlet UIButton *regt;
- (IBAction)registerClick:(UIButton *)sender;
- (IBAction)serviceInfo:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *promptInfo;
@property (weak, nonatomic) IBOutlet UIButton *updateAPlinfo;
@property (weak, nonatomic) IBOutlet UIButton *outAPLagain;

- (IBAction)actionUpadteAPL:(UIButton *)sender;

- (IBAction)actionAPLagin:(id)sender;

@end
