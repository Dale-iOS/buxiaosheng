//
//  ClientManagerViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户管理页面

#import "ClientManagerViewController.h"
#import "SGPagingView.h"
#import "ResponsibleViewController.h"
#import "AllCompanyViewController.h"
#import "NoneManagerViewController.h"
#import "FreezeViewController.h"
#import "DrawerAddressViewController.h"
#import "ChooseAddressVC.h"
#import "AddClienViewController.h"
#import "SearchClientViewController.h"

@interface ClientManagerViewController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation ClientManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self setipSGPagingView];
}

- (void)setupNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [Utility navTitleView:@"客户管理"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    UIButton *addBtn = [UIButton new];
    addBtn.frame = CGRectMake(0, 0, 19, 19);
    [addBtn setImage:IMAGE(@"addclient") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    UIButton *searchBtn = [UIButton new];
    searchBtn.frame = CGRectMake(0, 0, 19, 19);
    [searchBtn setImage:IMAGE(@"search") forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBtnItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    self.navigationItem.rightBarButtonItems = @[searchBtnItem,addBtnItem];
    
}

//横标题
- (void)setipSGPagingView
{

    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"我负责的", @"全公司的", @"无人负责的", @"冻结的"];
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
    
    ResponsibleViewController *vc1 = [[ResponsibleViewController alloc]init];
    AllCompanyViewController *vc2 = [[AllCompanyViewController alloc]init];
    NoneManagerViewController *vc3 = [[NoneManagerViewController alloc]init];
    FreezeViewController *vc4 = [[FreezeViewController alloc]init];
    
    NSArray *childArr = @[vc1, vc2, vc3, vc4];
    /// pageContentView
    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, _pageTitleView.bottom, APPWidth, contentViewHeight) parentVC:self childVCs:childArr];
    
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];

   
    UILabel *label = [[UILabel alloc]init];
    label.text = @"筛选";
    label.font = FONT(13);
    label.textColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = IMAGE(@"screenwihte");

}

#pragma mark ----- 点击事件 ------
- (void)addBtnOnClick
{
    AddClienViewController *vc = [[AddClienViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBtnOnClick
{
    SearchClientViewController *vc = [[SearchClientViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

// 导航栏左边按钮的点击事件
- (void)tapGesOnClick
{

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


@end
