//
//  BaseTableVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface BaseTableVC : BaseViewController

/// 主要的table
@property (nonatomic,strong)UITableView *mainTable;
/// 数据源
@property (nonatomic,strong)NSMutableArray *dataSource;
// 第几页的数据
@property (nonatomic,assign)NSInteger page;

@end
