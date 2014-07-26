//
//  TSStarRatingView.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TSStarRatingView;

@protocol StarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(TSStarRatingView *)view score:(float)score;

@end

@interface TSStarRatingView : UIView

- (id)initWithLabel:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;

@property (nonatomic,assign)float score;
@property (nonatomic, readonly) int numberOfStar;
@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;

@end

