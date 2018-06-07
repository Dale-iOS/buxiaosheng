//
//  LZSearchClientNeedsVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSearchClientNeedsVC.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"

@interface LZSearchClientNeedsVC ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>
//@property (nonatomic,strong)LZDrawerChooseView *chooseView;
//@property (nonatomic,strong)UIView *bottomBlackView;//侧滑的黑色底图
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation LZSearchClientNeedsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPageView];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"我的订单"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationScreenClick) image:IMAGE(@"screenDate")];
    
//    _bottomBlackView = [[UIView alloc]initWithFrame:self.view.bounds];
//    _bottomBlackView.backgroundColor = [UIColor blackColor];
//    _bottomBlackView.hidden = YES;
//    [self.view addSubview:_bottomBlackView];
//
//    [self setupChooseView];
}

- (void)setupPageView {
    
    
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"日历",@"周历",@"月历",@"季度"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = MAXFLOAT; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleSelectedColor = RGB(59, 177, 239);
    configure.indicatorColor = RGB(59, 177, 239);;
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:_pageTitleView];
    
    LLDayCalendarVc *dayVC = [[LLDayCalendarVc alloc] init];
    LLWeekCalendarVc *weekVC = [[LLWeekCalendarVc alloc] init];
    LLMonthCalendarVc *monthVC = [[LLMonthCalendarVc alloc] init];
    LLQuarterCalendarVc *quarterVC = [[LLQuarterCalendarVc alloc] init];
    
    NSArray *childArr = @[dayVC, weekVC, monthVC, quarterVC];
    /// pageContentView
//    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, 350) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    //    [self.view addSubview:_pageContentView];
    
    
    _bottomView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bottomView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    _bottomView.hidden = YES;
//    _bottomView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//    [_bottomView addGestureRecognizer:tap];
    [_bottomView addSubview:_pageTitleView];
    [_bottomView addSubview:_pageContentView];
    [self.view addSubview:_bottomView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


//- (void)setupChooseView
//{
//    //初始化抽屉
//    _chooseView = [[LZDrawerChooseView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight)];
//    _chooseView.delegate = self;
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:_chooseView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//    [_chooseView.alphaiView addGestureRecognizer:tap];
//}
//
//#pragma mark ----- 点击事件 ------
////滑出选择侧栏
- (void)navigationScreenClick
{
    _bottomView.hidden = NO;
}
- (void)tapClick
{
//    _bottomView.hidden = YES;
}

//
//- (void)dismiss
//{
//    [UIView animateWithDuration:0.35 animations:^{
//        _bottomBlackView.alpha = 0;
//        _chooseView .frame = CGRectMake(APPWidth, 0, APPWidth, APPHeight);
//
//    } completion:nil];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
