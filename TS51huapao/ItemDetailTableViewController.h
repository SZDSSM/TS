//
//  ItemDetailTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemDetail1TableViewCell.h"



@interface ItemDetailTableViewController : UITableViewController<TSGuanZhuProtocol,UIAlertViewDelegate>


@property (nonatomic, weak) id <TSGuanZhuProtocol> delegate;

@property (copy, nonatomic) NSString * itemcode;

@end
