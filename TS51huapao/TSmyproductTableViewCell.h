//
//  TSmyproductTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-8-2.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSFactorypost;

@interface TSmyproductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemimage;
@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *itemname;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) UIViewController  *sender;
@property (strong, nonatomic) TSFactorypost * post;

-(void)pushtoItemDetailView;

@end
