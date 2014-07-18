//
//  TSItemDetaillTableViewController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-14.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSItemDetaillTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *ItemName;
@property (weak, nonatomic) IBOutlet UIImageView *Productimage;

@property (weak, nonatomic) IBOutlet UILabel *presentPrice;
@property (weak, nonatomic) IBOutlet UILabel *priceNote;
@property (weak, nonatomic) IBOutlet UILabel *leftsum;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;


@property (weak, nonatomic) IBOutlet UILabel *cuxiao;
@property (weak, nonatomic) IBOutlet UIButton *zhijiang;
@property (weak, nonatomic) IBOutlet UIButton *fanli;

- (IBAction)guanzhu:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *guige;
@property (weak, nonatomic) IBOutlet UILabel *hanliang;
@property (weak, nonatomic) IBOutlet UILabel *xianggui;
@property (weak, nonatomic) IBOutlet UILabel *maozhong;

@property (weak, nonatomic) IBOutlet UILabel *haopindu;
@property (weak, nonatomic) IBOutlet UIView *star;
@property (weak, nonatomic) IBOutlet UILabel *yonghudiqu;
@property (weak, nonatomic) IBOutlet UILabel *xinde;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *tabarray;
@property (copy, nonatomic) NSString * itemcode;
@property (copy, nonatomic) NSMutableArray * labarray;


- (IBAction)boFangAnNiu:(id)sender;

@end
