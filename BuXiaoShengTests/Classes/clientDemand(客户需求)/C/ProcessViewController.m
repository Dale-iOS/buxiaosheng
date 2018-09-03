//
//  ProcessViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  指派页面

#import "ProcessViewController.h"
//采购
#import "LLProcessChildVc.h"
// 加工
#import "BXSMachiningVC.h"

@interface ProcessViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UISegmentedControl * segmented;
@property (nonatomic,strong) UIScrollView * containerView;
@property (nonatomic,strong) UILabel * totalNumberLable;

@end

@implementation ProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"指派"];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar的设置是全局的，一个页面设置了透明度，整个项目的页面都会变，把下面这句去掉
    [self setupUI];
    //    [self setupBottomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self setupProductDetail];
}

-(void)setupUI {
    UIView * segmentedView = [self segmentedView];
    [segmentedView layoutIfNeeded];
    [self.segmentedTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            //采购
            LLProcessChildVc *childVc = [[LLProcessChildVc alloc]init];
            childVc.orderId = self.orderId;
            childVc.title = obj;
            childVc.view.frame = CGRectMake(0, 0, APPWidth, self.containerView.height);
            [self.containerView addSubview:childVc.view];
            [self addChildViewController:childVc];
        }else{
            //加工
            BXSMachiningVC *childVc = [[BXSMachiningVC alloc]init];
            childVc.orderId = self.orderId;
            childVc.title = obj;
            childVc.view.frame = CGRectMake(APPWidth, 0, APPWidth, self.containerView.height);
            [self.containerView addSubview:childVc.view];
            [self addChildViewController:childVc];
        }
    }];
    
    LLProcessChildVc * fristVc = self.childViewControllers.firstObject;
    fristVc.view.frame = CGRectMake(0 , 0, SCREEN_WIDTH, CGRectGetHeight(self.containerView.frame));
    self.containerView.contentSize = CGSizeMake(SCREEN_WIDTH * self.segmentedTitles.count, self.containerView.height);
}

-(UIView *)setupBottomView {
    UIView * bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    self.totalNumberLable = [UILabel new];
    [bottomView addSubview:self.totalNumberLable];
    self.totalNumberLable.text = @"总数量: 8487484949";
    self.totalNumberLable.textColor = [UIColor colorWithHexString:@"#333333"];
    self.totalNumberLable.font = [UIFont systemFontOfSize:14];
    [self.totalNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(15);
        make.centerY.equalTo(bottomView);
    }];
    
    UIButton * determineBtn = [UIButton new];
    [determineBtn setTitle:@"确  定" forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineBtn setBackgroundColor:[UIColor colorWithHexString:@"#3d9bfa"]];
    [bottomView addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomView);
        make.width.mas_equalTo(LLScale_WIDTH(340));
    }];
    return bottomView;
}


-(void)segmentedClick {
    [self.containerView setContentOffset:CGPointMake(SCREEN_WIDTH * self.segmented.selectedSegmentIndex, 0) animated:true];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger index = offSetX / SCREEN_WIDTH;
    self.segmented.selectedSegmentIndex = index;
    LLProcessChildVc * childVc = self.childViewControllers[index];
    childVc.view.frame = scrollView.bounds;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}



-(UIView *)segmentedView {
    
    UIView *segmentedView = [UIView new];
    [self.view addSubview:segmentedView];
    [segmentedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.height.mas_equalTo(45);
    }];
    segmentedView.backgroundColor = [UIColor whiteColor];
    UISegmentedControl * segmented = [[UISegmentedControl alloc] initWithItems:self.segmentedTitles];
    self.segmented = segmented;
    [segmentedView addSubview:segmented];
    segmented.selectedSegmentIndex = 0;
    [segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(segmentedView);
        make.width.mas_equalTo(LLScale_WIDTH(360));
    }];
    [segmented addTarget:self action:@selector(segmentedClick) forControlEvents:UIControlEventValueChanged];
    
    return segmentedView;
}

-(NSArray<NSString *> *)segmentedTitles {
    if (!_segmentedTitles) {
        _segmentedTitles = @[@"采购",@"加工"];
    }
    return _segmentedTitles;
}

-(UIScrollView *)containerView {
    if (!_containerView) {
        _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, LLNavViewHeight + 45, SCREEN_WIDTH, SCREEN_HEIGHT - LLNavViewHeight - 45)];
        _containerView.delegate = self;
        _containerView.pagingEnabled = true;
        _containerView.bounces = NO;
        _containerView.scrollEnabled = NO;
        [self.view addSubview:_containerView];
    }
    return _containerView;
}

#pragma mark ---- 网络请求 ----
//接口名称 销售需求采购的产品的列表
- (void)setupProductDetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderId":self.orderId
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/product_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
