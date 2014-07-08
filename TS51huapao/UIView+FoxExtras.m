//
//  UIView+FoxExtras.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-1.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "UIView+FoxExtras.h"

@implementation UIView (FoxExtras)

//fox add method
-(void)addHuapaoyunshang
{
    CGRect rect=self.frame;
    rect.size.height=100;
    rect.origin.y=-100;
    
    CGRect rectimage=CGRectMake(rect.size.width/2-90, rect.size.height/2-15, 50, 50);
    CGRect rectlabel=CGRectMake(rect.size.width/2-35, rect.size.height/2-8, 50, 50);
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rectimage];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:@"51huapao.png"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 25;
    imageView.layer.borderColor = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f].CGColor;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize = YES;
    imageView.clipsToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:rectlabel];
    label.text = @"花炮云商";
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
    [label sizeToFit];
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [view addSubview:imageView];
    [view addSubview:label];
    [self addSubview:view];
}

-(UIView *)addRecommndFooterView:(id)sender
{
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame = CGRectMake(35, 20, 40, 40);
    UIImage *mg1=[UIImage imageNamed:@"call"];
    [bt setBackgroundImage:mg1 forState:UIControlStateNormal];
    
    if ([sender respondsToSelector:@selector(callButton:)]) {
        [bt addTarget:sender action:@selector(callButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 0, 24)];
    label.text = @"服务电话: 40067-51518";
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    [label sizeToFit];
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:label];
    [self addSubview:bt];
    return self;
}
@end
