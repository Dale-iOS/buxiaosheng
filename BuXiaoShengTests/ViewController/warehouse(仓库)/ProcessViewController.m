//
//  ProcessViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购加工页面

#import "ProcessViewController.h"
#import "LLProcessChildVc.h"

@interface ProcessViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UISegmentedControl * segmented;
@property (nonatomic,strong) UIScrollView * containerView;

@end

@implementation ProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"采购加工"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)setupUI {
    UIView * segmentedView = [self segmentedView];
    [segmentedView layoutIfNeeded];
    [self.segmentedTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LLProcessChildVc * childVc = [LLProcessChildVc new];
        childVc.title = obj;
        [self.containerView addSubview:childVc.view];
        [self addChildViewController:childVc];
    }];
    
    LLProcessChildVc * fristVc = self.childViewControllers.firstObject;
    fristVc.view.frame = CGRectMake(0 , 0, SCREEN_WIDTH, CGRectGetHeight(self.containerView.frame));
    self.containerView.contentSize = CGSizeMake(SCREEN_WIDTH * self.segmentedTitles.count, 0);
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
        make.top.equalTo(self.view).offset(64);
        make.height.mas_equalTo(45);
    }];
    segmentedView.backgroundColor = [UIColor whiteColor];
   UISegmentedControl * segmented = [[UISegmentedControl alloc] initWithItems:self.segmentedTitles];
    self.segmented = segmented;
    [segmentedView addSubview:segmented];
    segmented.selectedSegmentIndex = 0;
    [segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(segmentedView);
        make.width.mas_equalTo(100);
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
        [self.view addSubview:_containerView];
        _containerView.backgroundColor = [UIColor redColor];
    }
    return _containerView;
}


@end
