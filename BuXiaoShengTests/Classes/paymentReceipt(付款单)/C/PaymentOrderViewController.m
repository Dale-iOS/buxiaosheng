//
//  PaymentOrderViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  付款单页面

#import "PaymentOrderViewController.h"
#import "SGPagingView.h"
#import "SupplierViewController.h"
#import "ProducersViewController.h"
#import "ProcessorsViewController.h"
#import "LZPaymentOrderListVC.h"

@interface PaymentOrderViewController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation PaymentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"付款单"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"new_lists")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArr = @[@"供货商付款单", @"生产商付款单", @"加工商付款单"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    SupplierViewController *vc1 = [[SupplierViewController alloc]init];
    ProducersViewController *vc2 = [[ProducersViewController alloc]init];
    ProcessorsViewController *vc3 = [[ProcessorsViewController alloc]init];
    
    
    NSArray *childArr = @[vc1, vc2, vc3];
    /// pageContentView
    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, contentViewHeight) parentVC:self childVCs:childArr];
    
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
}


#pragma  mark -------- SGPageTitleViewDelegate --------
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


- (void)navigationSetupClick{
    LZPaymentOrderListVC *vc = [[LZPaymentOrderListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
