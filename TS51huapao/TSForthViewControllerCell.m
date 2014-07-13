//
//  TSForthViewControllerCell.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-9.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSForthViewControllerCell.h"

@implementation TSForthViewControllerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:247.0/255.0 blue:248.0/255.0 alpha:1.0];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _imageBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, 80, 80)];
        [_imageBackgroundView setBackgroundColor:[UIColor whiteColor]];
        
        _image=[[UIImageView alloc] init];
        _image.layer.cornerRadius=5;
        _image.layer.masksToBounds=YES;
        _image.frame=CGRectMake(8,8,64,64);
        
        _title=[[UILabel alloc] initWithFrame:CGRectMake(105, 15, 190, 35)];
        _title.text=@"标题";
        _title.textColor = [UIColor blackColor];
        //设置lable 的字体大小
        _title.font=[UIFont boldSystemFontOfSize:14];
        _title.numberOfLines = 0;
        [_title setLineBreakMode:NSLineBreakByWordWrapping];
        
        
        _content=[[UILabel alloc] initWithFrame:CGRectMake(105, 55, 185, 25)];
        _content.font = [UIFont fontWithName:@"Helvetica" size:10];
        _content.text=@"2013-12-11";
        _content.numberOfLines = 0;
        [_content setLineBreakMode:NSLineBreakByWordWrapping];
        //设置lable 的字体大小
        
        [_imageBackgroundView addSubview:_image];
        [self addSubview:_imageBackgroundView];
        [self addSubview:_title];
        [self addSubview:_content];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
