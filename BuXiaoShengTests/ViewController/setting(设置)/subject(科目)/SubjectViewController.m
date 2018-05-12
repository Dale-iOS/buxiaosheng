//
//  SubjectViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  科目页面

#import "SubjectViewController.h"
#import "SGPagingView.h"
#import "ManagerCostViewController.h"
#import "SellCostViewController.h"
#import "FinanceCostViewController.h"
#import "OtherCostViewController.h"
#import "AddSubjectViewController.h"

@interface SubjectViewController ()<SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setipSGPagingView];
}

- (void)setupNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [Utility navTitleView:@"科目"];
    //    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
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
    
    NSArray *titleArr = @[@"管理费用", @"销售费用", @"财务费用", @"其他费用"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    ManagerCostViewController *vc1 = [[ManagerCostViewController alloc]init];
    SellCostViewController *vc2 = [[SellCostViewController alloc]init];
    FinanceCostViewController *vc3 = [[FinanceCostViewController alloc]init];
    OtherCostViewController *vc4 = [[OtherCostViewController alloc]init];
    
    NSArray *childArr = @[vc1, vc2, vc3, vc4];
    /// pageContentView
    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, _pageTitleView.bottom, APPWidth, contentViewHeight) parentVC:self childVCs:childArr];
    
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    
    //    搜索框底图
    //    UIView *searchBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, 49)];
    //    searchBgView.backgroundColor = LZHBackgroundColor;
    //    [self.view addSubview:searchBgView];
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    //    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame)+5, APPWidth, 34)];
    //    _headView.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    _headView.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesOnClick)];
    //    [_headView addGestureRecognizer:tapGes];
    //    [self.view addSubview:_headView];
    //    NSLog(@"%f",_headLabel.right);
    //    UILabel *label = [[UILabel alloc]init];
    //    label.text = @"筛选";
    //    label.font = FONT(13);
    //    label.textColor = [UIColor whiteColor];
    //
    //    UIImageView *imageView = [[UIImageView alloc]init];
    //    imageView.image = IMAGE(@"screenwihte");
    //
    //    UIView *headBgView = [[UIView alloc]init];
    //    headBgView.backgroundColor = [UIColor clearColor];
    //    [headBgView addSubview:label];
    //    [headBgView addSubview:imageView];
    //    [_headView addSubview:headBgView];
    //
    //    headBgView.sd_layout
    //    .centerXEqualToView(_headView)
    //    .centerYEqualToView(_headView)
    //    .widthIs(45)
    //    .heightIs(14);
    //
    //    label.sd_layout
    //    .leftSpaceToView(headBgView, 0)
    //    .centerYEqualToView(headBgView)
    //    .widthIs(27)
    //    .heightIs(14);
    //
    //    imageView.sd_layout
    //    .rightSpaceToView(headBgView, 0)
    //    .centerYEqualToView(headBgView)
    //    .widthIs(14)
    //    .heightIs(12);
    //
    //
    //    _headLabel = [[UILabel alloc]init];
    //    _headLabel.text = @"共3人";
    //    _headLabel.textColor = CD_Text99;
    //    _headLabel.font = FONT(13);
    //    _headLabel.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:_headLabel];
    //    _headLabel.sd_layout
    //    .leftSpaceToView(self.view, 15)
    //    .topSpaceToView(_headView, 8)
    //    .widthIs(APPWidth/2)
    //    .heightIs(14);
    //
    
}

#pragma mark ----- pageTitleViewdelegate -----
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)navigationAddClick
{
    AddSubjectViewController *vc = [[AddSubjectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
