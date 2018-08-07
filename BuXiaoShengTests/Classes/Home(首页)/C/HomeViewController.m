//
//  HomeViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  首页页面

#import "HomeViewController.h"
#import "LZHTableView.h"
#import "SaleViewController.h"
#import "SGPagingView.h"
#import "NowDayViewController.h"
#import "NowMonthViewController.h"
#import "NowQuarterViewController.h"
#import "NowYearViewController.h"
//#import "AAChartKit.h"
#import "SetHomeViewController.h"
#import "LZHomeModel.h"
#import "FinancialCollectionViewCell.h"
#import "SaleViewController.h"
#import "FinancialViewController.h"
#import "WarehouseHomeViewController.h"
#import "LLHomePieChartModel.h"
#import "LLTurnoverChatView.h"
@interface HomeViewController ()<LZHTableViewDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///折线图
//@property (nonatomic, strong) AAChartView  *aaChartView;
//@property (nonatomic, strong) AAChartModel *aaChartModel;

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) NSArray <LZHomeModel *> *buttons;
@property (nonatomic, strong) UICollectionView *collectView;
@property(nonatomic ,strong)LLHomePieChartModel * pieChartModel;
@property(nonatomic ,strong)LLTurnoverChatView * chartView;
@end

@implementation HomeViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"homesetup")];

    self.datasource = [NSMutableArray array];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    
    self.mainTabelView.dataSoure = self.datasource;
    
    [self.view addSubview:self.mainTabelView];
     [self setupBtns];
    [self setupData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupBtns) name:LLLoginStateNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.titleView = [Utility navTitleView:[BXSUser currentUser].companyName];
}

#pragma mark ----- 网络请求 -------
- (void)setupBtns
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"home/button_home.do" param:param success:^(id response) {
        
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.buttons = [LZHomeModel LLMJParse:baseModel.data];
        if (self.buttons.count <5) {
            self.collectView.frame = CGRectMake(0, 20, APPWidth, 110);
        }else
        {
            self.collectView.frame = CGRectMake(0, 20, APPWidth, 220);
        }
        [self.collectView reloadData];
        [self.mainTabelView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"dateType":@"1"
                             };
    [BXSHttp requestGETWithAppURL:@"data_report/index.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.pieChartModel = [LLHomePieChartModel LLMJParse:baseModel.data];
        self.chartView.chartData =  self.pieChartModel.turnoverList;
    } failure:^(NSError *error) {
         BXS_Alert(LLLoadErrorMessage)
    }];
}

#pragma mark -------- lazy loading --------
- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, APPHeight)];
        tableView.tableView.allowsSelection = YES;
        [tableView setIsScrollEnable:NO];
        //        tableView.tableHeaderView = self.headView;
        //        tableView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /4, 100);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    flow.sectionInset = UIEdgeInsetsMake(0, APPWidth *0.05, 0,APPWidth *0.05);//上左下右
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, APPWidth, 200) collectionViewLayout:flow];
    
    [self.collectView registerClass:[FinancialCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.collectView];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.collectView];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasource addObject:item];
   
}

- (void)setSectionTwo
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = 200;
    self.chartView = [[LLTurnoverChatView alloc]initWithFrame:CGRectMake(0, 0, chartViewWidth, chartViewHeight)];
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //self.aaChartView.contentHeight = self.view.frame.size.height-250;
    [self.view addSubview:self.chartView];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.chartView ];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasource addObject:item];
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

#pragma mark -------- collectionView --------

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    FinancialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    LZHomeModel *model = [LZHomeModel LLMJParse:self.buttons[indexPath.row]];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LZHomeModel *model = [LZHomeModel LLMJParse:self.buttons[indexPath.row]];
    
    if ([model.paramsIos isEqualToString:@"sales"]) {
        
        SaleViewController *vc = [[SaleViewController alloc]init];
        vc.buttonId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"finance"])
    {
        FinancialViewController *vc = [[FinancialViewController alloc]init];
        vc.buttonId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"warehouse"])
    {
        WarehouseHomeViewController *vc = [[WarehouseHomeViewController alloc]init];
        vc.buttonId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buttons.count;
}

//设置itme大小
//-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(APPWidth /5, 80);
//}
//
////设置每个item的边距
//-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}


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
//- (void)entranceViewCellTapOnClick
//{
//
//    SaleViewController *saleVC = [[SaleViewController alloc]init];
//    [self.navigationController pushViewController:saleVC animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

