//
//  LZProcessReceiptVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZProcessReceiptVC.h"

@interface LZProcessReceiptVC ()

@end

@implementation LZProcessReceiptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"加工收货"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
