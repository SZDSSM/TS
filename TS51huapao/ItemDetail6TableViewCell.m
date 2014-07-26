//
//  ItemDetail6TableViewCell.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "ItemDetail6TableViewCell.h"

@implementation ItemDetail6TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
-(void)setPost:(TSItemCommentPost *)post
{
    _post=post;
    [self.starRatingView setScore:_post.leve];
    _labelCommentUser.text=_post.vipcode;
    _datetime.text=_post.commentdate;
    _labelComment.text=[@"心得:  " stringByAppendingString:_post.comment];
    
}

@end
