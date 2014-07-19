//
//  TSThridNavigationController.h
//  TS51huapao
//
//  Created by 张明生 on 14-7-18.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSThridNavigationController : UINavigationController


@property (nonatomic) NSArray *recentSearches;
@property (nonatomic) NSArray *displayedSearches;


- (void)addToRecentSearches:(NSString *)searchString;

@end
