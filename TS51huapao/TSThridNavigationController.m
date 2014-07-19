//
//  TSThridNavigationController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-18.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSThridNavigationController.h"




NSString *RecentSearchesKey = @"RecentSearchesKey";



@interface TSThridNavigationController ()

@end

@implementation TSThridNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // Set up the recent searches list, from user defaults or using an empty array.
    NSArray *recents = [[NSUserDefaults standardUserDefaults] objectForKey:RecentSearchesKey];
    if (recents) {
        self.recentSearches = recents;
        //self.displayedSearches = recents;
    }
    else {
        self.recentSearches = [NSArray array];
        //self.displayedSearches = [NSArray array];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addToRecentSearches:(NSString *)searchString {
    
    // Filter out any strings that shouldn't be in the recents list.
    if ([searchString isEqualToString:@""]) {
        return;
    }
    
    // Create a mutable copy of recent searches and remove the search string if it's already there (it's added to the top of the list later).
    
    NSMutableArray *mutableRecents = [self.recentSearches mutableCopy];
    [mutableRecents removeObject:searchString];
    
    if (mutableRecents.count>9) {
        [mutableRecents removeLastObject];
    }
    // Add the new string at the top of the list.
    [mutableRecents insertObject:searchString atIndex:0];
    
    // Update user defaults.
    [[NSUserDefaults standardUserDefaults] setObject:mutableRecents forKey:RecentSearchesKey];
    
    // Set self's recent searches to the new recents array, and reload the table view.
    self.recentSearches = mutableRecents;
    //self.displayedSearches = mutableRecents;
    //[self.recentSearcherTableview reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
