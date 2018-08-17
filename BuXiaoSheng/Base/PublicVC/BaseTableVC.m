//
//  BaseTableVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC

- (UITableView *)mainTable {
    
    if (!_mainTable) {
        
        _mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0) style:_isGrouped? UITableViewStyleGrouped:UITableViewStylePlain];
        [self.view addSubview:_mainTable];
        _mainTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        _mainTable.separatorColor  = LZHBackgroundColor;
        _mainTable.separatorInset = UIEdgeInsetsZero;
        _mainTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _mainTable.tableFooterView = [UIView new];
        _mainTable.estimatedRowHeight = 0;
        _mainTable.estimatedSectionHeaderHeight = 0;
        _mainTable.estimatedSectionFooterHeight = 0;
        
        
    }
    return _mainTable;
}

-(NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



+ (void)initialize {
    //初始化数据
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseTableVC];
    
}

- (void)setupBaseTableVC {
    
    self.page = 1;
    [self mainTable];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (@available(iOS 11.0, *))
    {
        self.mainTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    else
    {
        //self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}


@end
