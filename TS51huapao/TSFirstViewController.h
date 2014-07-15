//
//  TSFirstViewController.h
//  TS51huapao
//
//  Created by 80_xiaoye on 14-3-27.
//  Copyright (c) 2014年 Teesson Fireworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSRcmd.h"

@interface TSFirstViewController : UITableViewController

@property (copy, nonatomic) TSRcmd * prdctRcmd1;

@property (copy, nonatomic) TSRcmd * prdctRcmd2;

@property (copy, nonatomic) TSRcmd * prdctRcmd3;

@property (copy, nonatomic) TSRcmd * subjctRcmd1;

@property (copy, nonatomic) TSRcmd * subjctRcmd2;

@property (copy, nonatomic) TSRcmd * subjctRcmd3;



@property (copy, nonatomic) NSMutableArray * imagearray;

@property (copy, nonatomic) NSMutableArray * labelarray;

@property (copy, nonatomic) NSMutableDictionary * getDic;

@property (copy, nonatomic) NSString * telephoneNumeber;

@property (copy, nonatomic) NSMutableDictionary * prdct;

@property (copy, nonatomic) NSMutableDictionary * subjctRcmd;

//+ (NSURLSessionDataTask * )gblock:(void (^)(NSArray * posts, NSError * error))block;
@end
