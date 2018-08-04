//
//  LZDirectStorageVC.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/8/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDirectStorageVC.h"
#import "LZPurchaseViewController.h"//采购
#import "LZProcessViewController.h"//加工

@interface LZDirectStorageVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) UISegmentedControl *segmentControl;
@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation LZDirectStorageVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSegmentControl];
    [self setupAllChildrenVC];
    [self setupScrollView];
    
    [self handleSegmentedControl:_segmentControl];
    
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //处理scrollView与侧滑手势冲突
    [_scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

#pragma mark - Private Methods
- (void)setupSegmentControl {
    NSArray *items = @[@"采购",@"加工"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentControl.frame = CGRectMake(0, 0, 160, 35);
    [segmentControl addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    
    NSDictionary *selectedAttr = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                         NSForegroundColorAttributeName,
                         [UIFont boldSystemFontOfSize:15],
                         NSFontAttributeName,nil];
    [segmentControl setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];

    NSDictionary *normalAttr = [NSDictionary dictionaryWithObjectsAndKeys:[[UIColor blueColor] colorWithAlphaComponent:0.5],
                          NSForegroundColorAttributeName,
                          [UIFont boldSystemFontOfSize:15],
                          NSFontAttributeName,nil];
    
    [segmentControl setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    self.navigationItem.titleView = segmentControl;
    _segmentControl = segmentControl;
}

//添加所有子控制器
- (void)setupAllChildrenVC {
    [self addChildViewController:[[LZPurchaseViewController alloc] init]];
    [self addChildViewController:[[LZProcessViewController alloc] init]];
}

//设置滚动视图
- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    NSUInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(count * SCREEN_WIDTH, 0);
}

//添加第index个子控制器的view到scrollView
- (void)addChildVcViewIntoScrollView:(NSUInteger)index {
    UIViewController *childrenVC = self.childViewControllers[index];
    if (childrenVC.isViewLoaded) return;
    UIView *childerVCView = childrenVC.view;
    childerVCView.frame = CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(_scrollView.frame));
    [_scrollView addSubview:childerVCView];
}

#pragma mark - Events
- (void)handleSegmentedControl:(UISegmentedControl *)segmentControl {
    //滚动scrollView
    [_scrollView setContentOffset:CGPointMake(segmentControl.selectedSegmentIndex * SCREEN_WIDTH, 0) animated:NO];
    [self addChildVcViewIntoScrollView:segmentControl.selectedSegmentIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _segmentControl.selectedSegmentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self handleSegmentedControl:_segmentControl];
}

@end
