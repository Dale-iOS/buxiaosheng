//
//  LZDesignateVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  指派页面 

#import "LZDesignateVC.h"
//#import "LLProcessChildVc.h"
#import "LZPurchaseView.h"
#import "LZProcessView.h"

@interface LZDesignateVC ()<UIScrollViewDelegate>
//@property (nonatomic,weak) UISegmentedControl * segmented;
//@property (nonatomic,strong) UIScrollView * containerView;
//@property (nonatomic,strong) UILabel * totalNumberLable;
///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;
@property(nonatomic,strong)UISegmentedControl *sgc;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)LZPurchaseView *purchaseView;//采购
@property(nonatomic,strong)LZProcessView *processView;//加工
@end

@implementation LZDesignateVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"指派"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"list")];
    
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    _sgc = [[UISegmentedControl alloc]initWithItems:@[@"采购",@"加工"]];
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
    
    _purchaseView = [[LZPurchaseView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -LLNavViewHeight -50)];
    [_scrollView addSubview:_purchaseView];
    
    _processView = [[LZProcessView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight -LLNavViewHeight -50)];
    [_scrollView addSubview:_processView];
}

#pragma mark --- 点击事件 ---
- (void)navigationSetupClick{

}

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



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self setupUI];
//    [self setupBottomView];
//}
//
//-(void)setupUI {
//
//    self.navigationItem.titleView = [Utility navTitleView:@"指派"];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//
//    UIView * segmentedView = [self segmentedView];
//    [segmentedView layoutIfNeeded];
//    [self.segmentedTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        LLProcessChildVc * childVc = [LLProcessChildVc new];
//        childVc.title = obj;
//        [self.containerView addSubview:childVc.view];
//        [self addChildViewController:childVc];
//    }];
//
//    LLProcessChildVc * fristVc = self.childViewControllers.firstObject;
//    fristVc.view.frame = CGRectMake(0 , 0, SCREEN_WIDTH, CGRectGetHeight(self.containerView.frame));
//    self.containerView.contentSize = CGSizeMake(SCREEN_WIDTH * self.segmentedTitles.count, 0);
//}
//
//-(UIView *)setupBottomView {
//    UIView * bottomView = [UIView new];
//    [self.view addSubview:bottomView];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.height.mas_equalTo(50);
//    }];
//    self.totalNumberLable = [UILabel new];
//    [bottomView addSubview:self.totalNumberLable];
//    self.totalNumberLable.text = @"总数量: 8487484949";
//    self.totalNumberLable.textColor = [UIColor colorWithHexString:@"#333333"];
//    self.totalNumberLable.font = [UIFont systemFontOfSize:14];
//    [self.totalNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bottomView).offset(15);
//        make.centerY.equalTo(bottomView);
//    }];
//
//    UIButton * determineBtn = [UIButton new];
//    [determineBtn setTitle:@"确  定" forState:UIControlStateNormal];
//    determineBtn.titleLabel.font = [UIFont systemFontOfSize:17];
//    [determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [determineBtn setBackgroundColor:[UIColor colorWithHexString:@"#3d9bfa"]];
//    [bottomView addSubview:determineBtn];
//    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.top.bottom.equalTo(bottomView);
//        make.width.mas_equalTo(100);
//    }];
//    return bottomView;
//}
//
//
//-(void)segmentedClick {
//    [self.containerView setContentOffset:CGPointMake(SCREEN_WIDTH * self.segmented.selectedSegmentIndex, 0) animated:true];
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat offSetX = scrollView.contentOffset.x;
//    NSInteger index = offSetX / SCREEN_WIDTH;
//    self.segmented.selectedSegmentIndex = index;
//    LLProcessChildVc * childVc = self.childViewControllers[index];
//    childVc.view.frame = scrollView.bounds;
//}
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    [self scrollViewDidEndDecelerating:scrollView];
//}
//
//
//
//-(UIView *)segmentedView {
//
//    UIView *segmentedView = [UIView new];
//    [self.view addSubview:segmentedView];
//    [segmentedView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset(64);
//        make.height.mas_equalTo(45);
//    }];
//    segmentedView.backgroundColor = [UIColor whiteColor];
//    UISegmentedControl * segmented = [[UISegmentedControl alloc] initWithItems:self.segmentedTitles];
//    self.segmented = segmented;
//    [segmentedView addSubview:segmented];
//    segmented.selectedSegmentIndex = 0;
//    [segmented mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(segmentedView);
//        make.width.mas_equalTo(100);
//    }];
//    [segmented addTarget:self action:@selector(segmentedClick) forControlEvents:UIControlEventValueChanged];
//
//    return segmentedView;
//}
//
//-(NSArray<NSString *> *)segmentedTitles {
//    if (!_segmentedTitles) {
//        _segmentedTitles = @[@"采购",@"加工"];
//    }
//    return _segmentedTitles;
//}
//
//
//-(UIScrollView *)containerView {
//    if (!_containerView) {
//        _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, LLNavViewHeight + 45, SCREEN_WIDTH, SCREEN_HEIGHT - LLNavViewHeight - 45-50)];
//        _containerView.delegate = self;
//        _containerView.pagingEnabled = true;
//        [self.view addSubview:_containerView];
//    }
//    return _containerView;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
