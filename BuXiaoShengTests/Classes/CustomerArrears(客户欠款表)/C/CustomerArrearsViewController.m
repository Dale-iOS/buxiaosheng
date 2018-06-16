//
//  CustomerArrearsViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户欠款表页面（旧）

#import "CustomerArrearsViewController.h"
#import "CustomerArrearsTableViewCell.h"
#import "LZArrearClientView.h"
#import "LZArrearCompanyView.h"
#import "LZChooseArrearClientVC.h"


@interface CustomerArrearsViewController ()<UIScrollViewDelegate>
///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;
@property(nonatomic,strong)UISegmentedControl *sgc;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)LZArrearClientView *clienView;//客户
@property(nonatomic,strong)LZArrearCompanyView *companyView;//厂商
@end

@implementation CustomerArrearsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"客户欠款表"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toScreenClick) image:IMAGE(@"screen1")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    _sgc = [[UISegmentedControl alloc]initWithItems:@[@"客户",@"厂商"]];
    _sgc.selectedSegmentIndex = 0;
    _sgc.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [_sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.SegmentedBgView addSubview:_sgc];
    [_sgc mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.center.equalTo(self.SegmentedBgView);
        make.top.equalTo(self.SegmentedBgView).offset(6);
        make.centerX.equalTo(self.SegmentedBgView);
        make.width.mas_offset(180);
        make.height.mas_offset(30);
    }];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(APPWidth *2, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SegmentedBgView.mas_bottom).offset(3);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    //    _clienView = [[LZArrearClientView alloc]initWithFrame:CGRectZero];
    //    [_scrollView addSubview:_clienView];
    //    [_clienView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.and.top.equalTo(_scrollView);
    //        make.width.mas_offset(APPWidth);
    //        make.width.bottom.equalTo(_scrollView);
    //    }];
    _clienView = [[LZArrearClientView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight - LLNavViewHeight -35)];
    [_scrollView addSubview:_clienView];
    //    [_clienView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.and.top.equalTo(_scrollView);
    //        make.width.mas_offset(APPWidth);
    //        make.width.bottom.equalTo(_scrollView);
    //    }];
    _companyView = [[LZArrearCompanyView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight -LLNavViewHeight -35)];
    [_scrollView addSubview:_companyView];
    //    [_companyView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(_scrollView);
    //        make.left.equalTo(_scrollView.mas_left).offset(APPWidth);
    //        make.width.mas_offset(APPWidth);
    //        make.width.bottom.equalTo(_scrollView);
    //    }];
    //    [self setupHeadView];
    
}

//设置顶部
//- (void)setupHeadView
//{
//    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 49)];
//    self.headView.backgroundColor = LZHBackgroundColor;
//    [self.view addSubview:self.headView];
//
//    //客户名称
//    UILabel *titleLbl = [[UILabel alloc]init];
//    titleLbl.text = @"客户名称";
//    titleLbl.textColor = CD_Text33;
//    titleLbl.font = FONT(14);
//    titleLbl.textAlignment = NSTextAlignmentCenter;
//    [self.headView addSubview:titleLbl];
//
//    //应收借欠
//    UILabel *borrowLbl = [[UILabel alloc]init];
//    borrowLbl.text = @"应收借欠";
//    borrowLbl.textColor = CD_Text33;
//    borrowLbl.font = FONT(14);
//    borrowLbl.textAlignment = NSTextAlignmentCenter;
//    [self.headView addSubview:borrowLbl];
//
//    //最后还款日期
//    UILabel *payDateLbl = [[UILabel alloc]init];
//    payDateLbl.text = @"最后还款日期 ";
//    payDateLbl.textColor = CD_Text33;
//    payDateLbl.font = FONT(14);
//    payDateLbl.textAlignment = NSTextAlignmentCenter;
//    [self.headView addSubview:payDateLbl];
//
//    //业务员
//    UILabel *workerLbl = [[UILabel alloc]init];
//    workerLbl.text = @"业务员";
//    workerLbl.textColor = CD_Text33;
//    workerLbl.font = FONT(14);
//    workerLbl.textAlignment = NSTextAlignmentCenter;
//    [self.headView addSubview:workerLbl];
//
//    titleLbl.sd_layout
//    .leftSpaceToView(self.headView, 0)
//    .heightRatioToView(self.headView, 1)
//    .widthIs(APPWidth/4)
//    .topSpaceToView(self.headView, 0);
//
//    borrowLbl.sd_layout
//    .leftSpaceToView(titleLbl, 0)
//    .heightRatioToView(self.headView, 1)
//    .widthIs(APPWidth/4)
//    .topSpaceToView(self.headView, 0);
//
//    payDateLbl.sd_layout
//    .leftSpaceToView(borrowLbl, 0)
//    .heightRatioToView(self.headView, 1)
//    .widthIs(APPWidth/4)
//    .topSpaceToView(self.headView, 0);
//
//    workerLbl.sd_layout
//    .leftSpaceToView(payDateLbl, 0)
//    .heightRatioToView(self.headView, 1)
//    .widthIs(APPWidth/4)
//    .topSpaceToView(self.headView, 0);
//}

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

- (void)toScreenClick
{
    LZChooseArrearClientVC *vc = [[LZChooseArrearClientVC alloc]init];
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    [vc setSetectBlock:^(NSString *money, NSString *date) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
