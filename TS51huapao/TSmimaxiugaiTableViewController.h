//
//  TSmimaxiugaiTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-8-1.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSmimaxiugaiTableViewController : UITableViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldsec;
@property (weak, nonatomic) IBOutlet UITextField *newsec;
@property (weak, nonatomic) IBOutlet UITextField *newsecagain;
@property (weak, nonatomic) IBOutlet UIButton *tijiao;

- (IBAction)tijiao:(id)sender;

@end
