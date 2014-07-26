//
//  ItemDetail6TableViewCell.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSStarRatingView.h"
#import "TSItemCommentPost.h"

@interface ItemDetail6TableViewCell : UITableViewCell


@property (weak, nonatomic)TSItemCommentPost * post;

@property (weak, nonatomic) IBOutlet TSStarRatingView *starRatingView;

@property (weak, nonatomic) IBOutlet UILabel *labelCommentUser;

@property (weak, nonatomic) IBOutlet UILabel *labelComment;
@property (weak, nonatomic) IBOutlet UILabel *datetime;

@end
