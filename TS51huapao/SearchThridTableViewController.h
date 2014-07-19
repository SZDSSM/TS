//
//  SearchThridTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-19.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "TSThridNavigationController.h"
#import "UIButton+Style.h"

@protocol TsSearchbarProtocol <NSObject>

@optional
-(void)SearchButtonClicked:(NSString *)searchtxt;
@end



@interface SearchThridTableViewController : UITableViewController<UISearchBarDelegate>



//@property (weak, nonatomic) UINavigationController *ThridNavgCtrl;


/**
 Creates and runs an request.
 
 @param The SearchBar's text.
 @param The object that receives the action message.
 @param The action to send to target when this item is selected.
 @see -dataTaskWithRequest:completionHandler:
 */
- (id)initWithSearchTxt:(NSString *)searchTxt target:(UIViewController *)viewController action:(SEL)action;

@end
