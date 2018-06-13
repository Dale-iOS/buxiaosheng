//
//  LZPaymentOrderListVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPaymentOrderListVC.h"

@interface LZPaymentOrderListVC ()

@end

@implementation LZPaymentOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"付款单列表"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"screen1")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
