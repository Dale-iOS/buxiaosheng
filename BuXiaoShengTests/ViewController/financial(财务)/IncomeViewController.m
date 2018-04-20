//
//  IncomeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "IncomeViewController.h"

@interface IncomeViewController ()

@end

@implementation IncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"收款单"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
}





- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
