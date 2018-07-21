//
//  LZOrderFollowDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  订单跟踪详情页面

#import "LZOrderFollowDetailVC.h"

@interface LZOrderFollowDetailVC ()

@end

@implementation LZOrderFollowDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"订单跟踪详情"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
