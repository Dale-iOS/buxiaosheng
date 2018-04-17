//
//  DrawerAddressViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  选择地址抽屉

#import "DrawerAddressViewController.h"

@interface DrawerAddressViewController ()

@end

@implementation DrawerAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect rect = self.view.frame;
    
    switch (_drawerType) {
        case DrawerDefaultLeft:
            [self.view.superview sendSubviewToBack:self.view];
            break;
        case DrawerTypeMaskLeft:
            rect.size.width = kCWSCREENWIDTH * 0.75;
            break;
        default:
            break;
    }
    
    self.view.frame = rect;
}

- (void)setupUI
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
