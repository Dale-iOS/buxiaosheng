//
//  AuditViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  审批页面

#import "AuditViewController.h"
#import "AuditTableViewCell.h"
#import "SGPagingView.h"

#import "NoAuditSellViewController.h"
#import "NoAuditApplyViewController.h"
#import "NoAuditInStorageViewController.h"
#import "LZNoBackOrderVC.h"

@interface AuditViewController ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0+40+64, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
//    [self.view addSubview:self.tableView];
    
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    
    UISegmentedControl *sgc = [[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    sgc.selectedSegmentIndex = 0;
    sgc.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.SegmentedBgView addSubview:sgc];
    
    sgc.sd_layout
    .centerYEqualToView(self.SegmentedBgView)
    .centerXEqualToView(self.SegmentedBgView)
    .widthIs(180)
    .heightIs(30);
    
    NSArray *titleArr = @[@"销售单", @"入库单", @"报销单",@"退货单"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64+44, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    NoAuditInStorageViewController *vc1 = [[NoAuditInStorageViewController alloc]init];
    NoAuditSellViewController *vc2 = [[NoAuditSellViewController alloc]init];
    NoAuditApplyViewController *vc3 = [[NoAuditApplyViewController alloc]init];
    LZNoBackOrderVC *vc4 = [[LZNoBackOrderVC alloc]init];
    
    NSArray *childArr = @[vc1, vc2, vc3, vc4];
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

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AuditTableViewCell";
    AuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AuditTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)segClick:(UISegmentedControl *)sgc
{
    if (sgc.selectedSegmentIndex == 0) {

        NSLog(@"segClick1111");
    }else if (sgc.selectedSegmentIndex == 1)
    {
        NSLog(@"segClick2222");
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
