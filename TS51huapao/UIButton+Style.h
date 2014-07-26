//
//  UIButton+Style.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-6-23.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
@interface UIButton (Style)
- (void)addAwesomeIcon:(FAIcon)icon beforeTitle:(BOOL)before;
-(void)bootstrapStyle;
-(void)defaultStyle;
-(void)primaryStyle;
-(void)successStyle;
-(void)infoStyle;
-(void)warningStyle;
-(void)dangerStyle;
-(void)AttentionStyle;
-(void)callPhoneStyle;
-(void)submitStyle;
-(void)cancelAttentionStyle;
-(void)clearSearchReacodStyle;
-(void)guzhuqianStyle;
-(void)guzhuhouStyle;
-(void)backStyle;
//主流产品
-(void)mainProductStyle;
@end
