//
//  HomeViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  首页页面

#import "HomeViewController.h"
#import "LZHTableView.h"
#import "HomeEntranceView.h"
#import "SaleViewController.h"
#import "SGPagingView.h"
#import "NowDayViewController.h"
#import "NowMonthViewController.h"
#import "NowQuarterViewController.h"
#import "NowYearViewController.h"
#import "AAChartKit.h"
#import "SetHomeViewController.h"


@interface HomeViewController ()<LZHTableViewDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic, strong) UIView *headView;
///首页入口cell
@property (nonatomic, strong) HomeEntranceView *entranceViewCell;

///折线图
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic, strong) AAChartModel *aaChartModel;

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;


@end

@implementation HomeViewController
@synthesize mainTabelView,headView;

//- (id)init
//{
//    self = [self init];
//    if (self) {
//
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"龙纺布行"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"homesetup")];

    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self setupUI];
}

#pragma mark -------- lazy loading --------
- (UIView *)headView
{
    if (!headView) {
        
        //首页自定义导航栏底图View
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 14, self.view.frame.size.width, 45)];
        headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:(headView = headerView)];
        
        //龙纺布行 label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 75, 19)];
        titleLabel.text = @"龙纺布行";
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:titleLabel];
        
        //导航栏右上角设置按钮
//        UIButton *setupBtn = [UIButton new];
//        setupBtn.frame = CGRectMake(self.view.frame.size.width -15-20, 15, 20, 20);
//        [setupBtn setBackgroundImage:[UIImage imageNamed:@"homesetup"] forState:UIControlStateNormal];
//        [setupBtn addTarget:self action:@selector(setupBtnOnClickAciont) forControlEvents:UIControlEventTouchUpInside];
//        [headerView addSubview:setupBtn];
        
        //阴影
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.startPoint = CGPointMake(0.5, 0);
        layer.endPoint = CGPointMake(0.5, 1);
        layer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#eeeeee"].CGColor,(id)[UIColor whiteColor].CGColor, nil];
        layer.locations = @[@0.0f,@0.9f];
        layer.frame = CGRectMake(0, 45, self.view.frame.size.width, 5);
        
        [headerView.layer insertSublayer:layer atIndex:0];
    }
    return headView;
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 14+45, APPWidth, APPHeight)];
        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        //        tableView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    
    _entranceViewCell = [[HomeEntranceView alloc]init];
    _entranceViewCell.frame = CGRectMake(0, 0, APPWidth, 120);
    _entranceViewCell.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(entranceViewCellTapOnClick)];
//    [_entranceViewCell addGestureRecognizer:tap];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    //    item.sectionView = self.headView;
    item.sectionRows = @[_entranceViewCell];
    [self.datasource addObject:item];
    
}

- (void)setSectionTwo
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = 200;
    self.aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, chartViewWidth, chartViewHeight)];
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //self.aaChartView.contentHeight = self.view.frame.size.height-250;
    [self.view addSubview:self.aaChartView];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.aaChartView ];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
    AAChartModel *chartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)//设置图表的类型(这里以设置的为柱状图为例)
    .titleSet(@"编程语言热度")//设置图表标题
    .subtitleSet(@"虚拟数据")//设置图表副标题
    .categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++"])//设置图表横轴的内容
    .yAxisTitleSet(@"摄氏度")//设置图表 y 轴的单位
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@45,@56,@34,@43,@65,@56,@47,@28,@49]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@11,@12,@13,@14,@15,@16,@17,@18,@19]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2019")
                 .dataSet(@[@31,@22,@33,@54,@35,@36,@27,@38,@39]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2020")
                 .dataSet(@[@21,@22,@53,@24,@65,@26,@37,@28,@49]),
                 ])
    ;

    /*图表视图对象调用图表模型对象,绘制最终图形*/
    [_aaChartView aa_drawChartWithChartModel:chartModel];
    
    

}


- (void)setSectionThree
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
    
    NSArray *titleArr = @[@"本日", @"本月", @"季度", @"全年"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
//    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [ThreeBgView addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    NowDayViewController *dayVC = [[NowDayViewController alloc]init];
    NowMonthViewController *monthVC = [[NowMonthViewController alloc]init];
    NowQuarterViewController *quarterVC = [[NowQuarterViewController alloc]init];
    NowYearViewController *yearVC = [[NowYearViewController alloc]init];
    
    NSArray *childArr = @[dayVC, monthVC, quarterVC, yearVC];
    /// pageContentView
    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, contentViewHeight) parentVC:self childVCs:childArr];
    
    _pageContentView.delegatePageContentView = self;
    [ThreeBgView addSubview:_pageContentView];
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[ThreeBgView];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}


- (void)setupUI
{
    self.datasource = [NSMutableArray array];
    
    self.mainTabelView.tableHeaderView = self.headView;
    
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    
    self.mainTabelView.dataSoure = self.datasource;
    
}

#pragma  mark -------- SGPageTitleViewDelegate --------
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


#pragma mark -------- 点击事件 -----------
- (void)navigationSetupClick
{
    SetHomeViewController *vc = [[SetHomeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//点击销售入口按钮
- (void)entranceViewCellTapOnClick
{
    
    SaleViewController *saleVC = [[SaleViewController alloc]init];
    [self.navigationController pushViewController:saleVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

