//
//  SetCompanyViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  厂商页面

#import "SetCompanyViewController.h"
#import "SGPagingView.h"
#import "SupplierCompanyViewController.h"
#import "AddSetCompanyViewController.h"

@interface SetCompanyViewController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation SetCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self setupSGPagingView];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"厂商"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
}

- (void)setupSGPagingView
{
    UIView *ThreeBgView = [[UIView alloc]init];
    ThreeBgView.frame = CGRectMake(0, 0, APPWidth, 250);
    
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"供货商", @"生产商", @"加工商"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    SupplierCompanyViewController *supplierVC = [[SupplierCompanyViewController alloc]init];
    supplierVC.type = FactoryTypeGongHuoShang;
    
    SupplierCompanyViewController *productionVC = [[SupplierCompanyViewController alloc]init];
    productionVC.type = FactoryTypeShngChanShang;
    
    SupplierCompanyViewController *processVC = [[SupplierCompanyViewController alloc]init];
    processVC.type = FactoryTypeJiaGongShang;

    NSArray *childArr = @[supplierVC, productionVC, processVC];
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
    self.pageTitleView.selectedIndex = targetIndex;
}


- (void)navigationAddClick
{
    AddSetCompanyViewController *vc = [[AddSetCompanyViewController alloc]init];
    switch (self.pageTitleView.selectedIndex) {
        case 0:
            vc.type = FactoryTypeGongHuoShang;
            vc.navigationItem.titleView = [Utility navTitleView:@"添加供货商"];
            break;
        case 1:
            vc.type = FactoryTypeShngChanShang;
            vc.navigationItem.titleView = [Utility navTitleView:@"添加生产商"];
            break;
        case 2:
            vc.type = FactoryTypeJiaGongShang;
              vc.navigationItem.titleView = [Utility navTitleView:@"添加加工商"];
            break;
            
        default:
            break;
    }
    vc.isFormCompanyAdd = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
