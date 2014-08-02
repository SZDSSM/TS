//
//  TSMyComInfoTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-25.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSMyComInfoTableViewController.h"
#import "TSUser.h"

@interface TSMyComInfoTableViewController ()

@property (nonatomic, strong)NSMutableArray * itemArray;
@property (nonatomic, strong)TSUser * user;


@end

@implementation TSMyComInfoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    
    _user=[TSUser sharedUser];
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 5)]];
    if ([[_user.CARD_CardName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        self.comname.text = @"暂无";
    }else{
        self.comname.text = _user.CARD_CardName;
    }
    if ([[_user.CARD_Phone1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        self.contectnumber.text = @"暂无";
    }else{
        self.contectnumber.text = _user.CARD_Phone1;
    }
    if ([[_user.CARD_Address stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        self.address.text = @"暂无";
    }else{
        self.address.text = _user.CARD_Address;
    }
    if ([[_user.CARD_CntctPrsn stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        self.contectperson.text = @"暂无";
    }else{
        self.contectperson.text = _user.CARD_CntctPrsn;
    }
    if ([[_user.CARD_CntctPrsnCellolar stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        self.phoneNumber.text = @"暂无";
    }else{
        self.phoneNumber.text = _user.CARD_CntctPrsnCellolar;
    }
    self.comname.adjustsFontSizeToFitWidth = YES;
    self.contectnumber.adjustsFontSizeToFitWidth = YES;
    self.address.adjustsFontSizeToFitWidth = YES;
    self.contectperson.adjustsFontSizeToFitWidth = YES;
    self.phoneNumber.adjustsFontSizeToFitWidth = YES;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
