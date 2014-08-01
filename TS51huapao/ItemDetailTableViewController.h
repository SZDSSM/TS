//
//  ItemDetailTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemDetail1TableViewCell.h"


@protocol TsKanYanProtocol <NSObject>

@optional
-(void)KanYanButtonClicked;
@end


@interface ItemDetailTableViewController : UITableViewController<UIAlertViewDelegate>


@property (nonatomic, weak) id <TSGuanZhuProtocol> GuanZhudelegate;
@property (nonatomic, weak) id <TsKanYanProtocol> KanYandelegate;

- (void)xiadanCallback:(void (^)(int orderQty))callback;

@property (copy, nonatomic) NSString * itemcode;

@end
