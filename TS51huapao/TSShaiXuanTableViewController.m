//
//  TSShaiXuanTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-21.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSShaiXuanTableViewController.h"
#import "AFNetworking.h"


@interface TSShaiXuanTableViewController ()

@property (nonatomic,weak)UIViewController *callbackViewControl;
@property(nonatomic)SEL func_selector;


@property (nonatomic, strong)NSArray * tiaojian;
@property (nonatomic, strong)NSArray * tiaojianitem;
@property (nonatomic, strong)NSArray * qujian;
@property (nonatomic, strong)NSMutableDictionary * getDic;
@property (nonatomic, strong)NSArray * dataList;
@property (nonatomic, strong)NSIndexPath * selectIndex;
@property (nonatomic, strong)NSIndexPath * lastIndex;
@property (nonatomic) BOOL isOpen;
@property (nonatomic, strong)NSString * indicatetxt;

@end

@implementation TSShaiXuanTableViewController

-(void)shuaixuanAtTarget:(UIViewController *)target action:(SEL)action
{
    _callbackViewControl=target;
    _func_selector=action;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    [self _initTitleView];
    [self _initData];
    
    self.isOpen =  YES;
    
    _selectIndex=[NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)_initTitleView
{
    self.title = @"筛选";
    
    
    UINavigationItem *NavTitle = self.navigationItem;
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(quxiao:)];
    [item setTintColor:[UIColor grayColor]];
    
    //设置barbutton
    NavTitle.rightBarButtonItem = item;

}

- (void)_initData
{
    
    NSString * touchurl = @"http://124.232.163.242/com.ds.ws/FOXHttpHandler/FoxGetScreenList.ashx";
    NSString *URLTmp1 = [touchurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    touchurl = URLTmp1;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: touchurl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        requestTmp = [requestTmp stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        if (resData != nil) {
            //将获取到的数据JSON解析到数组中
            NSError *error;
            self.getDic = [[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:&error]mutableCopy];
            
            if ([self.itemName isEqualToString:@"爆竹类"]) {
                [_getDic removeObjectForKey:@"MEIFA"];
            }else if ([self.itemName hasPrefix:@"组合烟花类"]) {
                [_getDic removeObjectForKey:@"MEIWAN"];
                [_getDic removeObjectForKey:@"MEIPAN"];
            }else{
                [_getDic removeObjectForKey:@"MEIFA"];
                [_getDic removeObjectForKey:@"MEIWAN"];
                [_getDic removeObjectForKey:@"MEIPAN"];
            }
            self.tiaojianitem = [self.getDic allKeys];
            for (int i=0; i<_tiaojianitem.count; i++) {
                NSArray *ary=[_getDic objectForKey:[_tiaojianitem objectAtIndex:i]];
                for (NSString *str in ary) {
                    if ([str isEqualToString:_yixuan]){
                        _selectIndex=[NSIndexPath indexPathForRow:0 inSection:i];
                    }
                }
            }
//            self.dataList = [self.getDic objectForKey:@"TSItmsGrp"];
            [self.tableView reloadData];
            
        }else if(nil == resData){
            UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [AlertView1 show];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        UIAlertView *AlertView1=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未获取到数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [AlertView1 show];
    }];
    [operation start];
    
    
}

- (void)quxiao:(id)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_getDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [[self.getDic objectForKey:[_tiaojianitem objectAtIndex:section]] count]+2;;
        }
    }
    return 1;

}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0){
        static NSString *CellIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSMutableArray * array = [NSMutableArray arrayWithArray:[self.getDic objectForKey:[_tiaojianitem objectAtIndex:self.selectIndex.section]]];
        [array insertObject:@"全部" atIndex:0];

        cell.textLabel.text = [@"\t" stringByAppendingString:[array objectAtIndex:indexPath.row-1]];
        if (_yixuan !=nil && [cell.textLabel.text  hasSuffix:self.yixuan])
        {
            [cell.textLabel setTextColor:[UIColor redColor]];
            [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.textLabel.textColor = [UIColor grayColor];
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        [cell setBackgroundColor: [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
        
        
        

        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [self changeName:[_tiaojianitem objectAtIndex:indexPath.section]];
        if (indexPath.section==_selectIndex.section) {
            cell.detailTextLabel.text = _yixuan;
            cell.detailTextLabel.font=[UIFont systemFontOfSize:12];
        }

        [self changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO) For:cell];
        
        return cell;
    }
}

- (NSString *)changeName:(NSString *)name
{
    if ([name isEqualToString:@"MEIFA"])
        return @"每发";
    
    if ([name isEqualToString:@"MEIPAN"])
        return @"每盘";
    
    if ([name isEqualToString:@"MEIWAN"])
        return @"每万";
    
    if ([name isEqualToString:@"MEIXIANG"])
        return @"每箱";
    return name;
}

- (void)changeArrowWithUp:(BOOL)up For:(UITableViewCell *)cell
{
    if (up) {
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DownAccessory.png"]];
        cell.accessoryView = imageView;
        cell.accessoryType = UITableViewCellAccessoryNone;

    }else{
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = nil;

        }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
            
        }else
        {
            if (!self.selectIndex) {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
                
            }else
            {
                
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else
    {
//        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
//        NSArray *list = [dic objectForKey:@"list"];
        NSString * item = [NSString string];
        if (indexPath.row == 1) {
            item = @" ";
        }else{
            item = [[self.getDic objectForKey:[_tiaojianitem objectAtIndex:self.selectIndex.section]]objectAtIndex:indexPath.row-2];
        }
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_callbackViewControl performSelector:_func_selector withObject:item ];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectIndex];
    [self changeArrowWithUp:firstDoInsert For:cell];
    
    [self.tableView beginUpdates];
    
    int section = self.selectIndex.section;
    int contentCount = [[self.getDic objectForKey:[_tiaojianitem objectAtIndex:section]] count]+1;
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {   [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	
	[self.tableView endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}



@end
