//
//  ItemSearchTableViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "TSThridNavigationController.h"
#import "UIButton+Style.h"

@interface ItemSearchTableViewController : UITableViewController<UISearchBarDelegate>

@property (copy, nonatomic)  NSString *rightbuttonTitle;
@property (strong, nonatomic)  UISearchBar *searchBar;
/**
 Creates and return an searchtableviewcontroller.
 
 @param Use for get init nsarry with [[NSUserDefaults standardUserDefaults] objectForKey:SearchesKey].
 @param The searchbar's placeholder
 @param The object that receives the action message.
 @param The action to send to target when this item is selected.
 @see - (id)initWithSearchesKey:SearchPlaceholder:searchtext:target:action:.
 */
- (id)initWithSearchesKey:(NSString *)SearchesKey
        SearchPlaceholder:(NSString *)Placeholder
                   target:(UIViewController *)viewController
                   action:(SEL)action;
@end
