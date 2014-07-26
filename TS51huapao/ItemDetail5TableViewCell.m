//
//  ItemDetail5TableViewCell.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "ItemDetail5TableViewCell.h"

@implementation ItemDetail5TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

-(void)setPost:(TSItemDetailPost *)post
{
    _post=post;
    
    _labarray = [NSMutableArray arrayWithCapacity:10];
    if ([_post.IsEnsure isEqualToString:@"Y"])
        [_labarray addObject:@"保险保障"];
    
    if ([_post.IsFreeShip isEqualToString:@"Y"])
        [self.labarray addObject:@"物流运输"];
    
    if ([_post.IsTrade isEqualToString:@"Y"])
        [self.labarray addObject:@"交易保障"];
    
    if ([_post.IsQaTest isEqualToString:@"Y"])
        [self.labarray addObject:@"质量检查"];
    
    
    int i=1;
    for (UILabel * lb in self.tabarray)
    {
        if (i > [self.labarray count]){
            lb.hidden = YES;
            //            lb.text = [self.labarray objectAtIndex:i];
        }
        else{
            lb.hidden = NO;
            lb.text = [self.labarray objectAtIndex:i-1];
            lb.layer.borderWidth = 1;
            lb.layer.masksToBounds = YES;
            lb.layer.borderColor = [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
            
        }
        i ++;
    }
    
}

@end
