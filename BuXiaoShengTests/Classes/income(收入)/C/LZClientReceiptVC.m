//
//  LZClientReceiptVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZClientReceiptVC.h"

@interface LZClientReceiptVC ()

@end

@implementation LZClientReceiptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"客户收款单列表"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationRightClick) image:IMAGE(@"screen1")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)navigationRightClick{
    
}

@end
