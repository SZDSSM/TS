//
//  ItemSearchTableViewController.m
//  TS51huapao
//
//  Created by 80_xiaoye on 14-7-26.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "ItemSearchTableViewController.h"
#import "TSAppDoNetAPIClient.h"


@interface ItemSearchTableViewController ()

//searchbar click search
@property (weak, nonatomic) UIViewController *callbackObject;
@property (nonatomic) SEL func_selector;

//shuaixuan button click search
@property (weak, nonatomic) UIViewController *shuaiXuancallbackObject;
@property (nonatomic) SEL func_shuaiXuan;

@property (strong, nonatomic) UIBarButtonItem *searchItem;
@property (strong, nonatomic) UIBarButtonItem *rightButton;

@property(strong,nonatomic)UIButton *clearButton;
@property (copy, nonatomic)  NSString *type;
@property (copy, nonatomic)  NSString *RecentSearchesKey;

@property (nonatomic) NSArray *recentSearches;
@property (nonatomic) NSArray *displayedSearches;


@property (nonatomic) SEL selectRow;
@end


@implementation ItemSearchTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)searchbutton
{
    
    [_callbackObject.navigationItem setRightBarButtonItems:[[NSArray alloc]initWithObjects:_rightButton,nil] animated:YES];

//    CATransition *animation = [CATransition animation];
//    animation.type = kCATransitionFade;
//    animation.duration = 0.4;
//    [_callbackObject.navigationItem.titleView.layer addAnimation:animation forKey:nil];
    _callbackObject.navigationItem.titleView = self.searchBar;
    [_searchBar becomeFirstResponder];
    
}

- (id)initWithSearchesKey:(NSString *)SearchesKey
        SearchPlaceholder:(NSString *)Placeholder
                   target:(UIViewController *)viewController
                   action:(SEL)action
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        ////////////////////////////init _RecentSearchesKey
        _RecentSearchesKey=SearchesKey;
        if ([_RecentSearchesKey isEqualToString:@"ItemSearchesKey"]) {
            _type=@"I";
        }else{
            _type=@"C";
        }
        ////////////////////////////init sel
        _callbackObject=viewController;
        _func_selector=action;
        ////////////////////////////init searchbar
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,100,30)];
        
        [self.searchBar setBarTintColor:[UIColor groupTableViewBackgroundColor]];
        [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
        [self.searchBar setPlaceholder:Placeholder];
        
//        viewController.navigationItem.titleView = self.searchBar;
        self.searchBar.delegate=self;
        ///////////////////////////end  init searchbar
        
        [self readRecentSearch];
        
        
        //////////////////////////////init leftbuttton
        if (_callbackObject.navigationController.viewControllers.count>1) {
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle: @"く返回" style:UIBarButtonItemStylePlain target:self action:@selector(backbutton:)];
            [backItem setTintColor:[UIColor lightGrayColor]];
            
            viewController.navigationItem.leftBarButtonItem = backItem;
        }else{
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 42, 30)]];
        }
        
        //////////////////////////////init rightbuttton
        _searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchbutton)];
        [_searchItem setTintColor:[UIColor lightGrayColor]];

        _rightButton = [[UIBarButtonItem alloc] initWithTitle: @"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(cancelbuton)];
        [_rightButton setTintColor:[UIColor lightGrayColor]];
        
        viewController.navigationItem.rightBarButtonItems = [[NSArray alloc]initWithObjects:_rightButton,_searchItem,nil];

        // Set up the recent searches list, from user defaults or using an empty array.
        
        
        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
        
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
            _clearButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


-(void)backbutton:(UIBarButtonItem *)sender
{
    if ([_searchBar isFirstResponder]) {
        [_searchBar resignFirstResponder];
    }
    if ([self.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow] ) {
            [self.tableView removeFromSuperview];
            [_callbackObject.navigationController popViewControllerAnimated:YES];

    }else{
        [_callbackObject.navigationController popViewControllerAnimated:YES];
    }
}
//////////////////////search bar//////////////////////////////////////////////////////////////////
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
    _searchBar.text=@"";
    [_searchBar resignFirstResponder];
    if ([_rightButton.title isEqualToString:NSLocalizedString(@"Cancel", @"")]) {
        [_rightButton setTitle:@"关闭"];
        [self.tableView removeFromSuperview];
        
        [_callbackObject.navigationItem setRightBarButtonItems:[[NSArray alloc]initWithObjects:_rightButton,_searchItem,nil] animated:YES];

        [_callbackObject.navigationItem setTitleView:nil];
    }
    else if ([_rightButton.title isEqualToString:@"关闭"]) {
        [self backbutton:nil];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // When the search string changes, filter the recents list accordingly.
    [self filterResultsUsingString:searchText];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _clearButton.hidden=NO;
    if (![_rightButton.title isEqualToString:NSLocalizedString(@"Cancel", @"")]) {
        [_rightButton setTitle:NSLocalizedString(@"Cancel", @"")];
    }
    
    if (![self.tableView.superview isEqual:[UIApplication sharedApplication].keyWindow]) {
        
        [[UIApplication sharedApplication].keyWindow addSubview: self.tableView];
        [self readRecentSearch];
        _displayedSearches=_recentSearches;
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, 20) animated:NO];
        [self.tableView reloadData];
    }

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
    
}

- (void)filterResultsUsingString:(NSString *)filterString {
    
    // If the search string is zero-length, then restore the recent searches, otherwise
    // create a predicate to filter the recent searches using the search string.
    //
    _displayedSearches =_recentSearches;
    
    if ([filterString length] == 0) {
        _displayedSearches = _recentSearches;
        _clearButton.hidden=NO;
        [self.tableView reloadData];
    }
    else {
        
        [[TSAppDoNetAPIClient sharedClient] GET:@"FoxGetSearchTableWithString.ashx" parameters:@{@"str":filterString,@"type":_type} success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *rslt=[responseObject objectForKey:@"SearchTable"];
            _displayedSearches=rslt;
            _clearButton.hidden=YES;
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", filterString];
            NSArray *filteredRecentSearches = [_recentSearches filteredArrayUsingPredicate:filterPredicate];
            _displayedSearches = filteredRecentSearches;
            [self.tableView reloadData];
        }];
    }
    
    
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
