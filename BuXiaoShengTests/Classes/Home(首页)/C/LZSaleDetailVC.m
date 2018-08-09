//
//  LZSaleDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSaleDetailVC.h"

@interface LZSaleDetailVC ()

@end

@implementation LZSaleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"xx销售详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
