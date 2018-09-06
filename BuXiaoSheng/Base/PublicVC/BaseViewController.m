//
//  BaseViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = LZHBackgroundColor;
    //修复左滑返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
//    NSLog(@"✈️✈️ 界面新建= %@ ✈️✈️",[super class]);
}


-(void)dealloc{
//    NSLog(@"💣💣 界面销毁= %@ 💣💣",[super class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
