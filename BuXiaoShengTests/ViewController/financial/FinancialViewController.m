//
//  FinancialViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "FinancialViewController.h"
#import "DataSource.h"
#import "YANScrollMenu.h"
#import "LZHTableView.h"

@interface FinancialViewController ()<YANScrollMenuDelegate,YANScrollMenuDataSource,LZHTableViewDelegate>
@property (nonatomic, weak) LZHTableView *mainTabelView;

@end

@implementation FinancialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.title = @"销售";
    self.navigationItem.titleView = [Utility navTitleView:@"财务"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
