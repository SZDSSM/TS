//
//  TSfactoryTableViewController.m
//  TS51huapao
//
//  Created by 张明生 on 14-7-18.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import "TSfactoryTableViewController.h"
#import "TSFactorypost.h"
#import "UIKit+AFNetworking.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "TSItemTableViewCell.h"
#import "TSCoLtdpost.h"


@interface TSfactoryTableViewController ()

@property(nonatomic)BOOL heartisview;

@end

@implementation TSfactoryTableViewController

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
    
    _heartisview=NO;
    [self _init];
    
    UINib * nib = [UINib nibWithNibName:@"TSItemTableViewCell" bundle:nil];
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)_init
{
    self.page = 1;
    
    [self.tableView setTableHeaderView:({
        
        UILabel *titlelabel=[[UILabel alloc] init];
        titlelabel.frame=CGRectMake(15, 9, 300, 22);
        titlelabel.backgroundColor=[UIColor clearColor];
        titlelabel.textColor=[UIColor lightGrayColor];
        titlelabel.font=[UIFont systemFontOfSize:17];
        titlelabel.text=_Coltdpost.CardName;
        
        UILabel * uplinelable = [[UILabel alloc] init];
        uplinelable.frame = CGRectMake(15, 38, ScreenWidth-30, 1);
        uplinelable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
        
        UILabel * firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 45, ScreenWidth, 20)];
        [self lableStyle:firstLabel];
        firstLabel.text = [NSMutableString stringWithFormat:@"联  系  人: %@",_Coltdpost.CntctPrsn];
        
        UILabel *  SencondLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 70, 20, 50)];
        [self lableStyle:SencondLabel];
        SencondLabel.text = @"地       址: ";
        [SencondLabel sizeToFit];
        
        UILabel * SecondTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(SencondLabel.frame.origin.x + SencondLabel.frame.size.width, 69, ScreenWidth - 75, 20)];
        [self lableStyle:SecondTextLabel];
        SecondTextLabel.adjustsFontSizeToFitWidth = YES;
        SecondTextLabel.minimumScaleFactor = .7f;
        SecondTextLabel.text = _Coltdpost.Address;
        
        UILabel * ThirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 90, 20, 20)];
        [self lableStyle:ThirdLabel];
        ThirdLabel.text = @"客户区域: ";
        [ThirdLabel sizeToFit];
        
        UILabel * ThirdTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 90, ScreenWidth - 75, 20)];
        [self lableStyle:ThirdTextLabel];
        ThirdTextLabel.text = _Coltdpost.ClientArea;
        [ThirdLabel sizeToFit];
        
        
        UILabel * ForthLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 110, 70, 20)];
        [self lableStyle:ForthLabel];
        ForthLabel.text = @"主要产品: ";
        
        UILabel * ForthTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 113, ScreenWidth - 100, 20)];
        ForthTextLabel.numberOfLines = 0;
        [self lableStyle:ForthTextLabel];
        NSMutableAttributedString * ForthattributtedString = [[NSMutableAttributedString alloc] initWithString:_Coltdpost.UMainPro];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:3.0f];
        [ForthattributtedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_Coltdpost.UMainPro length])];
        ForthTextLabel.attributedText = ForthattributtedString;
        
        
        [ForthTextLabel sizeToFit];
        
        UIButton * phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(17, ForthTextLabel.frame.origin.y + ForthTextLabel.frame.size.height, 320, 28)];
       [self lableStyle:phoneButton.titleLabel];
        [phoneButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -170, 0, 0)];
        phoneButton.backgroundColor = [UIColor whiteColor];
        [phoneButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [phoneButton setTitle:[NSMutableString stringWithFormat:@"联系电话: %@",_Coltdpost.Cellolar] forState:UIControlStateNormal];
        [phoneButton addTarget:self action:@selector(phone:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * downLineLable = [[UILabel alloc] init];
        downLineLable.frame = CGRectMake(0, phoneButton.frame.origin.y + phoneButton.frame.size.height + 10, ScreenWidth, 7);
        downLineLable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
        
        UILabel * sixthLable = [[UILabel alloc] init];
        sixthLable.frame=CGRectMake(15, downLineLable.frame.origin.y + downLineLable.frame.size.height + 10, 300, 22);
        sixthLable.backgroundColor=[UIColor clearColor];
        sixthLable.textColor=[UIColor lightGrayColor];
        sixthLable.font=[UIFont systemFontOfSize:17];
        sixthLable.text=@"主要生产";
        
        UILabel * linelable = [[UILabel alloc] init];
        linelable.frame = CGRectMake(15, sixthLable.frame.origin.y + sixthLable.frame.size.height + 7, ScreenWidth-30, 1);
        linelable.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];

        
        
        
        // Create header view and add label as a subview
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 250)];
        [sectionView setBackgroundColor:[UIColor whiteColor]];
        [sectionView addSubview:titlelabel];
        [sectionView addSubview:uplinelable];
        [sectionView addSubview:firstLabel];
        [sectionView addSubview:SecondTextLabel];
        [sectionView addSubview:SencondLabel];
        [sectionView addSubview:ThirdLabel];
        [sectionView addSubview:ThirdTextLabel];
        [sectionView addSubview:ForthTextLabel];
        [sectionView addSubview:ForthLabel];
        [sectionView addSubview:phoneButton];
        [sectionView addSubview:downLineLable];
        [sectionView addSubview:sixthLable];
        [sectionView addSubview:linelable];
         sectionView;})];
    
    [self setupRefresh];
    //[self getData];

}

- (void)phone:(UIButton *)sender
{
    NSString *call=[NSString stringWithFormat:@"tel://%@",_Coltdpost.Cellolar];//telprompt 打电话前先弹框  是否打电话 然后打完电话之后回到程序中,可能不合法无法通过审核
    NSURL *callURL=[NSURL URLWithString:call];
    [[UIApplication sharedApplication] openURL:callURL];
}

- (void)lableStyle:(UILabel *)lable
{
    [lable setTextColor:[UIColor grayColor]];
    lable.font = [UIFont boldSystemFontOfSize:14];
}

- (void)getData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    _CardCode = _Coltdpost.CardCode;
    if ( _CardCode!=nil) {
        [dic setObject:_CardCode forKey:@"CardCode"];
    }
    [dic setObject:[NSString stringWithFormat:@"%u",_page] forKey:@"pageindex"];
    
    NSURLSessionDataTask * task = [TSFactorypost globalTimeGetRecommendInfoWithDictionary:dic Block:^(NSArray *posts,NSUInteger maxcount, NSError *error) {
        if (!error) {
            _maxcount=maxcount;
            if (_page>1) {
                _posts=[_posts arrayByAddingObjectsFromArray:posts];
            }else{
                _posts = posts;
            }
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
        }
    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
    //[UIActivityIndicatorView set ]
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉花炮云商标语
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView headerBeginRefreshing];
    // 2.添加上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _page=1;
    [self getData];
}

- (void)footerRereshing
{
    if (_posts.count<_maxcount) {
        _page=_page+1;
        [self getData];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"通知" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        //[alert show];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView footerEndRefreshing];
            [alert show];
        });
    }
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return  _posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (nil == cell) {
        cell = [[TSItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    // Configure the cell...
    cell.thirdPageFacPost = [self.posts objectAtIndex:indexPath.row];
    cell.order.hidden = YES;
    
//    cell.itemimage.layer.shadowColor = [UIColor blackColor].CGColor;
//    cell.itemimage.layer.shadowOffset = CGSizeMake(7, 7);
//    cell.itemimage.layer.shadowOpacity = 0.5;
//    cell.itemimage.layer.shadowRadius = 0.6f;
//    [cell.itemimage layer].borderColor = [[UIColor blackColor] CGColor];
//    [cell.itemimage layer].borderWidth = 5.0f;
    
    return cell;
}


#pragma mark-------------------scroll delegate----------------
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //Selected index's color changed.
//    static float newy = 0;
//    static float oldy = 0;
//    newy= scrollView.contentOffset.y ;
//    if (newy != oldy ) {
//        //Left-YES,Right-NO
//        if (newy > oldy+10) {
//            self.scrollupordown = NO;
//            if (_heartisview) {
//                //[self.tableView reloadData];
//                [_heartview setFrame:CGRectMake(0, 0, 0, 0)];
//            }
//        }else if(newy+10 < oldy){
//            self.scrollupordown = YES;
//            if (!_heartisview) {
//                //[self.tableView reloadData];
//                [_heartview setFrame:CGRectMake(0, 0, 320, 150)];
//            }
//        }
//        oldy = newy;
//    }
//}

@end
