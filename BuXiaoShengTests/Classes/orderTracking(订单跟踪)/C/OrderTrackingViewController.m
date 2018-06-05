//
//  OrderTrackingViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  订单跟踪页面

#import "OrderTrackingViewController.h"
#import "SGPagingView.h"
//#import "AllOrderViewController.h"
#import "WaitOutOrderViewController.h"
#import "DidOutOrderViewController.h"
#import "ShipmentOrderViewController.h"
#import "DeliveryOrderViewController.h"

@interface OrderTrackingViewController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation OrderTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = [Utility navTitleView:@"订单跟踪"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toSearch) image:IMAGE(@"search")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setSgPageTitleView];
}

- (void)setSgPageTitleView
{
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[ @"待出库", @"已出库", @"待出货", @"已交货"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
//    self.pageTitleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;

    
//    AllOrderViewController *allVC = [[AllOrderViewController alloc]init];
    WaitOutOrderViewController *watiOutVC = [[WaitOutOrderViewController alloc]init];
    DidOutOrderViewController *didOutVC = [[DidOutOrderViewController alloc]init];
    ShipmentOrderViewController *shipmentVC = [[ShipmentOrderViewController alloc]init];
    DeliveryOrderViewController *deliveryVC = [[DeliveryOrderViewController alloc]init];
    
    NSArray *childArr = @[watiOutVC, didOutVC, shipmentVC, deliveryVC];
    /// pageContentView
    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, contentViewHeight) parentVC:self childVCs:childArr];
    
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
}

#pragma mark ----- pageTitleViewdelegate -----
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (void)toSearch
{
    
}


@end
