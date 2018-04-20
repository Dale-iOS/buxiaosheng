//
//  FinancialViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "FinancialViewController.h"
#import "DataSource.h"
#import "YANScrollMenu.h"
#import "LZHTableView.h"
#import "SGPagingView.h"
#import "NowDayViewController.h"
#import "NowMonthViewController.h"
#import "NowQuarterViewController.h"
#import "NowYearViewController.h"
#import "FinancialCollectionViewCell.h"
#import "IncomeViewController.h"

@interface FinancialViewController ()<YANScrollMenuDelegate,YANScrollMenuDataSource,LZHTableViewDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate,UICollectionViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation FinancialViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.title = @"销售";
    self.navigationItem.titleView = [Utility navTitleView:@"财务"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
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

- (void)setCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /4, 100);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, APPWidth, 200) collectionViewLayout:flow];
    
    [self.collectView registerClass:[FinancialCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
}

//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    //    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    FinancialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
   
    
    if (indexPath.row == 0) {
        
        cell.iconImageView.image = IMAGE(@"sale");
        //    cell.backgroundColor = [UIColor redColor];
//        cell.iconImageView.backgroundColor = [UIColor whiteColor];
    }
    else if (indexPath.row == 1)
    {
        cell.iconImageView.image = IMAGE(@"spending");
        cell.titileLabel.text = @"支出";
    }
    else if (indexPath.row == 2)
    {
        cell.iconImageView.image = IMAGE(@"audit");
        cell.titileLabel.text = @"审批";
    }
    else if (indexPath.row == 3)
    {
        cell.iconImageView.image = IMAGE(@"payment");
        cell.titileLabel.text = @"付款单";
    }
    else if (indexPath.row == 4)
    {
        cell.iconImageView.image = IMAGE(@"bankdetail");
        cell.titileLabel.text = @"银行明细";
    }
    else if (indexPath.row == 5)
    {
        cell.iconImageView.image = IMAGE(@"banktransfer");
        cell.titileLabel.text = @"银行互转";
    }
    else if (indexPath.row == 6)
    {
        cell.iconImageView.image = IMAGE(@"customerarrears");
        cell.titileLabel.text = @"客户欠款单";
    }
    else if (indexPath.row == 7)
    {
        cell.iconImageView.image = IMAGE(@"clientreconciliation");
        cell.titileLabel.text = @"客户对账表";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {

        IncomeViewController *vc = [[IncomeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {

    }
    else if (indexPath.row == 2)
    {

    }
    else if (indexPath.row == 3)
    {
       
    }
}

//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(APPWidth /5, 80);
}

//设置每个item的边距
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (void)setupUI
{
    self.datasource = [NSMutableArray array];
    
    [self setSectionOne];
    [self setSectionTwo];
//    [self setSectionThree];
    
    self.mainTabelView.dataSoure = self.datasource;
    
}


- (void)setSectionOne
{
    
    [self setCollectionView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.collectView];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
    
}

- (void)setSectionTwo
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
    
    NSArray *titleArr = @[@"年", @"季度", @"月", @"日"];
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

#pragma  mark -------- SGPageTitleViewDelegate --------
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
