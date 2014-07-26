//
//  ItemDetail5TableViewCell.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSItemDetailPost.h"
@interface ItemDetail5TableViewCell : UITableViewCell


@property (weak, nonatomic)TSItemDetailPost * post;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *tabarray;
@property (copy, nonatomic) NSMutableArray * labarray;

@end
