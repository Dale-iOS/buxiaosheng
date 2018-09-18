//
//  BXSStockDemandVC.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  BXSStockPurchaseVC
//  备货需求页面
#import "BXSStockDemandVC.h"
#import "BXSStockPurchaseVC.h"//采购
#import "BXSStockMachiningVC.h"//加工
#import "LZStockDemandListVC.h"


@interface BXSStockDemandVC ()<UIScrollViewDelegate>

@property (nonatomic,weak) UISegmentedControl * segmented;
@property (nonatomic,strong) UIScrollView * containerView;
@property (nonatomic,strong) UILabel * totalNumberLable;


@property (nonatomic,strong) NSArray <NSString *> * segmentedTitles;
@property (nonatomic,strong)BXSStockMachiningVC * machiningVC;
@end

@implementation BXSStockDemandVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"备货需求"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(rightBarButtonItemClick) image:IMAGE(@"new_lists")];
    //self.navigationController.navigationBar的设置是全局的，一个页面设置了透明度，整个项目的页面都会变，把下面这句去掉
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setupUI];
    
}

-(void)setupUI {
    UIView * segmentedView = [self segmentedView];
    [segmentedView layoutIfNeeded];
	WEAKSELF
    [self.segmentedTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            BXSStockPurchaseVC *childVc = [[BXSStockPurchaseVC alloc]init];
            //采购
            childVc.title = obj;
            childVc.view.frame = CGRectMake(0, 0, APPWidth, self.containerView.height);
            [self.containerView addSubview:childVc.view];
            [self addChildViewController:childVc];

			childVc.requestProductListBlock = ^(NSMutableArray *productsListNameArray, NSMutableArray *productsListIdArray) {
				weakSelf.machiningVC.productsListNameArray = productsListNameArray;
				weakSelf.machiningVC.productsListIdArray = productsListIdArray;

			};
        }else{
            self.machiningVC = [[BXSStockMachiningVC alloc]init];
            //加工
            self.machiningVC.title = obj;
            self.machiningVC.view.frame = CGRectMake(APPWidth, 0, APPWidth, self.containerView.height);
            [self.containerView addSubview:self.machiningVC.view];
            [self addChildViewController:self.machiningVC];
        }
    }];
    
    BXSStockPurchaseVC * fristVc = self.childViewControllers.firstObject;
    fristVc.view.frame = CGRectMake(0 , 0, SCREEN_WIDTH, CGRectGetHeight(self.containerView.frame));
    self.containerView.contentSize = CGSizeMake(SCREEN_WIDTH * self.segmentedTitles.count, self.containerView.height);
}

-(void)segmentedClick {
    [self.containerView setContentOffset:CGPointMake(SCREEN_WIDTH * self.segmented.selectedSegmentIndex, 0) animated:true];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger index = offSetX / SCREEN_WIDTH;
    self.segmented.selectedSegmentIndex = index;
    BXSStockPurchaseVC * childVc = self.childViewControllers[index];
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

#pragma mark --- 点击事件 ---
- (void)rightBarButtonItemClick{
    LZStockDemandListVC *vc = [[LZStockDemandListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
