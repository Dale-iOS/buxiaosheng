//
//  LZProcessAskVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZProcessAskVC.h"

@interface LZProcessAskVC ()

@end

@implementation LZProcessAskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"加工询问"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
