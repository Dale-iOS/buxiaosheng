//
//  AuditViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  审批页面

#import "AuditViewController.h"
#import "SGPagingView.h"

#import "NoAuditSellViewController.h"
#import "NoAuditApplyViewController.h"
#import "NoAuditInStorageViewController.h"
#import "LZNoBackOrderVC.h"
#import "LZDIdSaleAuditVC.h"
#import "LZDidToWarehouseAuditVC.h"
#import "LZDidReimbursementSaleVC.h"
#import "LZDidNoBackOrderVC.h"

@interface AuditViewController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate,UIScrollViewDelegate>

///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView1;
@property (nonatomic, strong) SGPageContentView *pageContentView1;
@property(nonatomic,strong)UISegmentedControl *sgc;
@end

@implementation AuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    
    self.navigationItem.titleView = [Utility navTitleView:@"审批"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    
    _sgc = [[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    _sgc.selectedSegmentIndex = 0;
    _sgc.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [_sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.SegmentedBgView addSubview:_sgc];
    
    _sgc.sd_layout
    .centerYEqualToView(self.SegmentedBgView)
    .centerXEqualToView(self.SegmentedBgView)
    .widthIs(180)
    .heightIs(30);
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(APPWidth *2, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SegmentedBgView.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    NSArray *titleArr = @[@"销售单", @"入库单", @"报销单",@"退货单"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, LLNavViewHeight+44, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    NoAuditSellViewController *vc1 = [[NoAuditSellViewController alloc]init];
    NoAuditInStorageViewController *vc2 = [[NoAuditInStorageViewController alloc]init];
    NoAuditApplyViewController *vc3 = [[NoAuditApplyViewController alloc]init];
    LZNoBackOrderVC *vc4 = [[LZNoBackOrderVC alloc]init];
    
    NSArray *childArr = @[vc1, vc2, vc3, vc4];
    /// pageContentView
    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, 38, APPWidth, contentViewHeight) parentVC:self childVCs:childArr];
    
    _pageContentView.delegatePageContentView = self;
    [_scrollView addSubview:_pageContentView];
    
    
    
    
    self.pageTitleView1 = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(APPWidth, 64+44, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView1];
    _pageTitleView.selectedIndex = 0;
    
//    NSArray *titleArr1 = @[@"销售单", @"入库单", @"报销单",@"退货单"];
    SGPageTitleViewConfigure *configure1 = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure1.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure1.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure1.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView1 = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(APPWidth, 64+44, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView1];
    _pageTitleView1.selectedIndex = 0;

    
    LZDIdSaleAuditVC *vc5 = [[LZDIdSaleAuditVC alloc]init];
    LZDidToWarehouseAuditVC *vc6 = [[LZDidToWarehouseAuditVC alloc]init];
    LZDidReimbursementSaleVC *vc7 = [[LZDidReimbursementSaleVC alloc]init];
    LZDidNoBackOrderVC *vc8 = [[LZDidNoBackOrderVC alloc]init];
    
    NSArray *childArr1 = @[vc5, vc6, vc7, vc8];
    /// pageContentView
    CGFloat contentViewHeight1 = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView1 = [[SGPageContentView alloc] initWithFrame:CGRectMake(APPWidth, 38, APPWidth, contentViewHeight1) parentVC:self childVCs:childArr1];
    
    _pageContentView1.delegatePageContentView = self;
    [_scrollView addSubview:_pageContentView1];
    
}

#pragma mark ----- pageTitleViewdelegate -----
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
    [self.pageContentView1 setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    [self.pageTitleView1 setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


#pragma mark --- 点击事件 ----
//分段选择器方法
- (void)segClick:(UISegmentedControl *)sgc
{
    
    if (sgc.selectedSegmentIndex == 0) {
        _scrollView.contentOffset = CGPointMake(0, 0);
        
    }else if (sgc.selectedSegmentIndex == 1)
    {
        _scrollView.contentOffset = CGPointMake(APPWidth, 0);
    }
    
}

//轮播图偏移方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x /APPWidth >= 1) {
        _sgc.selectedSegmentIndex = 1;
    }else if (scrollView.contentOffset.x /APPWidth < 1)
    {
        _sgc.selectedSegmentIndex = 0;
    }
    
}



- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
