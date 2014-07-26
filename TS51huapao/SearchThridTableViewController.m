//
//  SearchThridTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-19.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//
//#import "message.h"
#import "SearchThridTableViewController.h"
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//NSString *RecentSearchesKey = @"RecentSearchesKey";

@interface SearchThridTableViewController ()

//searchbar click search
@property (weak, nonatomic) UIViewController *callbackObject;
@property (nonatomic) SEL func_selector;

//shuaixuan button click search
@property (weak, nonatomic) UIViewController *shuaiXuancallbackObject;
@property (nonatomic) SEL func_shuaiXuan;

@property (weak, nonatomic) UIBarButtonItem *rightButton;
@property (weak, nonatomic) UIBarButtonItem *leftButton;



@property (copy, nonatomic)  NSString *RecentSearchesKey;

@property (nonatomic) NSArray *recentSearches;
@property (nonatomic) NSArray *displayedSearches;

@property (nonatomic, assign) id <TsSearchbarProtocol> delegate;

@property (nonatomic) SEL selectRow;
@end

@implementation SearchThridTableViewController

#pragma mark -init method

-(void)readRecentSearch
{
    NSArray *recents = [[NSUserDefaults standardUserDefaults] objectForKey:_RecentSearchesKey];
    if (recents) {
        self.recentSearches = recents;
    }
    else if(_recentSearches){
    }
    else{
        self.recentSearches = [NSArray array];
    }
}


-(void)shuaixuanAtTarget:(UIViewController *)target action:(SEL)action
{
    _shuaiXuancallbackObject=target;
    _func_shuaiXuan=action;
}


#pragma mark -view
- (id)initWithSearchesKey:(NSString *)SearchesKey
        SearchPlaceholder:(NSString *)Placeholder
                   target:(UIViewController *)viewController
                   action:(SEL)action
{
    return [self initWithSearchesKey:SearchesKey SearchPlaceholder:Placeholder searchtext:nil rightButtonTitle:nil target:viewController action:action];
}
#pragma mark -view
- (id)initWithSearchesKey:(NSString *)SearchesKey
        SearchPlaceholder:(NSString *)Placeholder
               searchtext:(NSString *)searchTxt
         rightButtonTitle:(NSString *)rightButtonTitle
                   target:(UIViewController *)viewController
                   action:(SEL)action
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        ////////////////////////////init _RecentSearchesKey
        _RecentSearchesKey=SearchesKey;
        ////////////////////////////init sel
        _callbackObject=viewController;
        _func_selector=action;
        
        
        ////////////////////////////init searchbar
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,100,30)];
        
        [self.searchBar setBarTintColor:[UIColor groupTableViewBackgroundColor]];
        [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
        [self.searchBar setPlaceholder:Placeholder];
        
        ////////////////////////////init searchTxt
        if (searchTxt.length>0) {
            self.searchBar.text=searchTxt;
        }
        viewController.navigationItem.titleView = self.searchBar;
        self.searchBar.delegate=self;
        ///////////////////////////end  init searchbar
        
        [self readRecentSearch];
        
        
        
        //////////////////////////////init leftbuttton
        if (_callbackObject.navigationController.viewControllers.count>1) {
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle: @"く返回" style:UIBarButtonItemStylePlain target:self action:@selector(backbutton)];
            [backItem setTintColor:[UIColor lightGrayColor]];
            
            viewController.navigationItem.leftBarButtonItem = backItem;
        }else{
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 42, 30)]];
        }


        //////////////////////////////init rightbuttton
        
        if (rightButtonTitle !=nil) {
            _rightbuttonTitle=rightButtonTitle;
        }else{
            _rightbuttonTitle=@"";//NSLocalizedString(@"Search", @"");
        }
        viewController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:_rightbuttonTitle style:UIBarButtonItemStyleBordered target:self action:@selector(cancelbuton)];
        self.rightButton=viewController.navigationItem.rightBarButtonItem;
        [self.rightButton setTintColor:[UIColor lightGrayColor]];
        // Set up the recent searches list, from user defaults or using an empty array.
        
        
        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight)];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.view.bounds];
        [toolbar setAlpha:0.99];
        //[toolbar setBackgroundColor:[UIColor whiteColor]];
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        [self.tableView setBackgroundView:toolbar];
        
        self.tableView.tableFooterView = ({
            UILabel * Separatorlabel = [[UILabel alloc]init];
            Separatorlabel.frame = CGRectMake(15, 0, ScreenWidth, 1);
            Separatorlabel.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120.0f)];
            view.backgroundColor=[UIColor clearColor];
            UIButton * _clearButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            _clearButton.frame=CGRectMake(10, 10, 300, 38);
            [_clearButton setTitle:@"清空搜索记录" forState:UIControlStateNormal];
            [_clearButton addTarget:self action:@selector(clearButClik) forControlEvents:UIControlEventTouchUpInside];
            [_clearButton clearSearchReacodStyle];
            
            [view addSubview:Separatorlabel];
            [view addSubview:_clearButton];
            view;
        });
        
    }
    return self;
}


-(void)backbutton
{
    if ([_searchBar isFirstResponder]) {
        [_searchBar resignFirstResponder];
    }
    if ([self.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow] ) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView removeFromSuperview];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 0.4* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_callbackObject.navigationController popViewControllerAnimated:YES];
        });
    }else{
        [_callbackObject.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


//-(void)dealloc
//{
//    if ([self.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow] ) {
//        [self.tableView removeFromSuperview];
//    }
//}

- (void)addToRecentSearches:(NSString *)searchString {
    
    // Filter out any strings that shouldn't be in the recents list.
    if ([searchString isEqualToString:@""]) {
        return;
    }
    
    // Create a mutable copy of recent searches and remove the search string if it's already there (it's added to the top of the list later).
    
    NSMutableArray *mutableRecents = [self.recentSearches mutableCopy];
    [mutableRecents removeObject:searchString];
    
    if (mutableRecents.count>14) {
        [mutableRecents removeLastObject];
    }
    // Add the new string at the top of the list.
    [mutableRecents insertObject:searchString atIndex:0];
    
    // Update user defaults.
    [[NSUserDefaults standardUserDefaults] setObject:mutableRecents forKey:_RecentSearchesKey];
    
    // Set self's recent searches to the new recents array, and reload the table view.
    self.recentSearches = mutableRecents;
    //self.displayedSearches = mutableRecents;
    //[self.recentSearcherTableview reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark---------------searchBar delegate-----------
//#pragma mark---------------searchBar delegate-----------
//// -------------------------------------------------------------------------------
////	scrollViewDidEndDecelerating:
//// -------------------------------------------------------------------------------

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableView]) {
        if ([_searchBar isFirstResponder]) {
            [_searchBar resignFirstResponder];
        }
    }
}
-(void)clearButClik
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:_RecentSearchesKey];
    _recentSearches = [NSArray array];
    _displayedSearches = [NSArray array];
    [self.tableView reloadData];
}

-(void)cancelbuton
{
    [_searchBar resignFirstResponder];
    if ([_rightButton.title isEqualToString:NSLocalizedString(@"Cancel", @"")]) {
        [_rightButton setTitle:_rightbuttonTitle];
        if ([self.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow] ) {
            [self.tableView removeFromSuperview];
            //pppppp[self.tableView setScrollEnabled:YES];
        }
    }else if ([_rightButton.title isEqualToString:@"筛选"]) {
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if( [_shuaiXuancallbackObject respondsToSelector:_func_shuaiXuan])
        {
            //objc_msgSend(_callbackObject,_func_selector,searchBar.text);
            [_shuaiXuancallbackObject performSelector:_func_shuaiXuan];
        }
    }
    
    if (![_rightbuttonTitle isEqualToString:@"筛选"]){
        [_searchBar setText:@""];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // When the search string changes, filter the recents list accordingly.
    [self filterResultsUsingString:searchText];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    if (![self.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow]) {
        
        [[UIApplication sharedApplication].keyWindow addSubview: self.tableView];
        [self readRecentSearch];
        _displayedSearches=_recentSearches;
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, 20) animated:NO];
        [self.tableView reloadData];
    }
    if (![_rightButton.title isEqualToString:NSLocalizedString(@"Cancel", @"")]) {
        [_rightButton setTitle:NSLocalizedString(@"Cancel", @"")];
    }
    // Create the popover if it is not already open.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self addToRecentSearches:self.searchBar.text];
    //objc_msgSend
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if( [_callbackObject respondsToSelector:_func_selector])
    {
        //objc_msgSend(_callbackObject,_func_selector,searchBar.text);
        [_callbackObject performSelector:_func_selector withObject:searchBar.text];
    }
    [self cancelbuton];
//    if ([_delegate respondsToSelector:@selector(SearchButtonClicked:)]) {
//        [_delegate SearchButtonClicked:searchBar.text];
//    }
    
    
}

- (void)filterResultsUsingString:(NSString *)filterString {
    
    // If the search string is zero-length, then restore the recent searches, otherwise
    // create a predicate to filter the recent searches using the search string.
    //
    _displayedSearches =_recentSearches;
    
    if ([filterString length] == 0) {
        _displayedSearches = _recentSearches;
    }
    else {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", filterString];
        NSArray *filteredRecentSearches = [_recentSearches filteredArrayUsingPredicate:filterPredicate];
        _displayedSearches = filteredRecentSearches;
    }
    [self.tableView reloadData];
    
}
//////////////////////search bar//////////////////////////////////////////////////////////////////


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [_displayedSearches count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchCell"];
    }
    cell.textLabel.text = [_displayedSearches objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_searchBar setText:[_displayedSearches objectAtIndex:indexPath.row]];
    [self searchBarSearchButtonClicked:_searchBar];
}

@end
