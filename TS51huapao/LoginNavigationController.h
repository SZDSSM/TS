//
//  LoginNavigationController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-29.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginNavigationController : UINavigationController


/**
 *  登录回到（我）页面就会调用
 */
- (void)addVipInfoRefreshWithCallback:(void (^)())callback;

-(void)refreshVipInfoWithCallback;
@end
