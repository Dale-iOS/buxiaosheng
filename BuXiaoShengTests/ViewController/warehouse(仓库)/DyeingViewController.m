//
//  DyeingViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  织造染色页面

#import "DyeingViewController.h"

@interface DyeingViewController ()

@end

@implementation DyeingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"织造染色"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
