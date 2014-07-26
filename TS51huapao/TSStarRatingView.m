//
//  TSStarRatingView.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSStarRatingView.h"

@interface TSStarRatingView ()

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;

@end

@implementation TSStarRatingView


- (id)initWithLabel:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = 5;
        _starBackgroundView = [self buidlStarViewWithLabelString:@"☆"];
        _starForegroundView = [self buidlStarViewWithLabelString:@"★"];
        [self addSubview:_starBackgroundView];
        [self addSubview:_starForegroundView];
    }
    
    return self;
}

- (UIView *)buidlStarViewWithLabelString:(NSString *)string
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height)];
        [label setText:string];//★ @"☆"
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:[UIColor redColor]];
        [view addSubview:label];
    }
    
    
    return view;
}


-(void)setScore:(float)score
{

    _numberOfStar = 5;
    if ([_starBackgroundView.superview isEqual: self]) {
        [_starBackgroundView removeFromSuperview];
    }
    if ([_starForegroundView.superview isEqual: self]) {
        [_starForegroundView removeFromSuperview];
    }
    
    _starBackgroundView = [self buidlStarViewWithLabelString:@"☆"];
    _starForegroundView = [self buidlStarViewWithLabelString:@"★"];
    [self addSubview:_starBackgroundView];
    [self addSubview:_starForegroundView];
    
    if (score>10.0) {
        _score=10.0;
    }else{
        _score=score;
    }
    _score=(_score/10)*self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, _score, self.frame.size.height);
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:5];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        self.starBackgroundView = [self buidlStarViewWithImageName:@"backgroundStar"];
        self.starForegroundView = [self buidlStarViewWithImageName:@"foregroundStar"];
        [self addSubview:self.starBackgroundView];
        [self addSubview:self.starForegroundView];
    }
    return self;
}
/*
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point))
    {
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak TSStarRatingView * weekSelf = self;
    
    [UIView transitionWithView:self.starForegroundView
                      duration:0.2
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^
     {
         [weekSelf changeStarForegroundViewWithPoint:point];
     }
                    completion:^(BOOL finished)
     {
         
     }];
}
*/
- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    
    if (p.x < 0)
    {
        p.x = 0;
    }
    else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",p.x / self.frame.size.width];
    float score = [str floatValue];
    p.x = score * self.frame.size.width;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)])
    {
        [self.delegate starRatingView:self score:score];
    }
}
@end
