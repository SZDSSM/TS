//
//  TSItemTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-13.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSItemListPost;
@class TSFactorypost;
@interface TSItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *itemname;
@property (weak, nonatomic) IBOutlet UIImageView *itemimage;
@property (weak, nonatomic) IBOutlet UILabel *Spec;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UIButton *zhixiao;
@property (weak, nonatomic) IBOutlet UIButton *fanli;
@property (weak, nonatomic) IBOutlet UIButton *guanzhu;
- (IBAction)guanzhu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *order;

@property (strong, nonatomic) TSItemListPost * post;
@property (strong, nonatomic) TSFactorypost * thirdPageFacPost;

@property (weak, nonatomic) IBOutlet UIButton *mtv;

@end
