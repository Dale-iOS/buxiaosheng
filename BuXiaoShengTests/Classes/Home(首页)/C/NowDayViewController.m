//
//  NowDayViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  本日VC

#import "NowDayViewController.h"
#import "LLHomePieChartModel.h"
@interface NowDayViewController ()<ChartViewDelegate>
@property(nonatomic ,strong)PieChartView * pieChartView;
@property(nonatomic ,strong)LLHomePieChartModel * pieChartModel;
@end

@implementation NowDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupUI];
//    [self setupData];
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
