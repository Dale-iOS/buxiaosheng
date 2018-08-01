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
#import "SpendingViewController.h"
#import "AuditViewController.h"
#import "PaymentOrderViewController.h"
#import "BankDetailViewController.h"
#import "BankDetailListViewController.h"
#import "CustomerArrearsViewController.h"
#import "CustomerReconciliationViewController.h"
#import "LZHomeModel.h"
#import "LZIncomeVC.h"
#import "BankConversionViewController.h"
#import "LZCustomerArrearsVC.h"
#import "LZDetailCell.h"
#import "CashBankViewController.h"

@interface FinancialViewController ()<YANScrollMenuDelegate,YANScrollMenuDataSource,LZHTableViewDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate,UICollectionViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) UICollectionView *collectView;
@property(nonatomic,strong)LZDetailCell *bankCell;
@property (nonatomic, strong) NSArray <LZHomeModel *> *buttons;
@end

@implementation FinancialViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"财务"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupBtns];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
//        tableView.tableView.allowsSelection = NO;
        [tableView setIsScrollEnable:NO];
        //        tableView.tableHeaderView = self.headView;
        //        tableView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /5, 80);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = APPWidth *0.05;
    flow.sectionInset = UIEdgeInsetsMake(0, APPWidth *0.05, 0,APPWidth *0.05);//上左下右
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,10, APPWidth, 200) collectionViewLayout:flow];
    
    [self.collectView registerClass:[FinancialCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.collectView];
}

//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buttons.count;
}

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
    
    if ([model.paramsIos isEqualToString:@"receipt"]) {
        //收入
        LZIncomeVC *vc = [[LZIncomeVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
     if ([model.paramsIos isEqualToString:@"expend"])
    {
        //支出
        SpendingViewController *vc = [[SpendingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
     if ([model.paramsIos isEqualToString:@"approval"])
    {
        //审批
        AuditViewController *vc = [[AuditViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
     if ([model.paramsIos isEqualToString:@"receiptorder"])
    {
       //付款单
        PaymentOrderViewController *vc = [[PaymentOrderViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
     if ([model.paramsIos isEqualToString:@"bankdetail"])
    {
        //银行明细
        BankDetailViewController *vc = [[BankDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
     if ([model.paramsIos isEqualToString:@"banktransfer"])
    {   //银行互转
        BankConversionViewController *vc = [[BankConversionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
     if ([model.paramsIos isEqualToString:@"customarrear"])
    {
        //客户欠款表
        LZCustomerArrearsVC *vc = [[LZCustomerArrearsVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
     if ([model.paramsIos isEqualToString:@"reconciliation"])
    {
//        客户对账
        CustomerReconciliationViewController *vc = [[CustomerReconciliationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

////设置itme大小
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

- (void)setupUI
{
    self.datasource = [NSMutableArray array];
    
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    
    self.mainTabelView.dataSoure = self.datasource;
//    [self.mainTabelView setIsScrollEnable:NO];
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
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    self.bankCell = [[LZDetailCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.bankCell.leftIMV.image = IMAGE(@"cashbank");
    self.bankCell.titleLabel.text = @"现金银行";
    self.bankCell.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapBenkCell = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBenkCellClick)];
    [self.bankCell addGestureRecognizer:tapBenkCell];

    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.bankCell];
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

#pragma mark ----- 网络请求 -------
- (void)setupBtns
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buttonId":self.buttonId
                             };
    [BXSHttp requestGETWithAppURL:@"home/button_page.do" param:param success:^(id response) {
        
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.buttons = [LZHomeModel LLMJParse:baseModel.data];
//        if (self.buttons.count <5) {
//            self.collectView.frame = CGRectMake(0, 0, APPWidth, 110);
//        }else
//        {
//            self.collectView.frame = CGRectMake(0, 0, APPWidth, 220);
//        }
        [self.collectView reloadData];
        [self.mainTabelView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

#pragma  mark -------- SGPageTitleViewDelegate --------
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)tapBenkCellClick{
    CashBankViewController *vc = [[CashBankViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

 

@end
