//
//  TSkanyangTableViewCell.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-30.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSItemListPost.h"

@interface TSkanyangTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *contectperson;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UIImageView *itemimage;
@property (weak, nonatomic) IBOutlet UILabel *itemname;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *cardname;

@property (weak, nonatomic) IBOutlet UIButton *guzhu;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;



- (IBAction)guanzhu:(UIButton *)sender;
@property (nonatomic, strong) TSItemListPost * kanyangpost;

@end
