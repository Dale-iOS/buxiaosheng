//
//  DyeingDemandViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  织染需求页面

#import "DyeingDemandViewController.h"
#import "HRTabView.h"
#import "HRTableViewOne.h"

#import "SegmentDyeingViewController.h"
#import "SegmentDyeingView.h"
#import "SegmentProcessView.h"

@interface DyeingDemandViewController ()<UIScrollViewDelegate>

///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation DyeingDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"织染需求"];
    
//    [self setupUI];
    [self setupSegment];
    [self settingScrollView];
}



- (void)setupUI
{
//    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 40)];
//    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
//
//    [self.view addSubview:self.SegmentedBgView];
//
//    UISegmentedControl *sgc = [[UISegmentedControl alloc]initWithItems:@[@"织造",@"染色"]];
//    sgc.selectedSegmentIndex = 0;
//    sgc.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
//    [sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
//    [self.SegmentedBgView addSubview:sgc];
//
//    sgc.sd_layout
//    .centerYEqualToView(self.SegmentedBgView)
//    .centerXEqualToView(self.SegmentedBgView)
//    .widthIs(180)
//    .heightIs(30);
}

- (void)setupSegment
{
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"织造",@"染色"]];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClick) forControlEvents:UIControlEventValueChanged];
    self.segment = segment;
    [self.SegmentedBgView addSubview:self.segment];
    segment.sd_layout
    .centerYEqualToView(self.SegmentedBgView)
    .centerXEqualToView(self.SegmentedBgView)
    .widthIs(180)
    .heightIs(30);
}

- (void)settingScrollView{
    
//    HRTabView *tableView = [[HRTabView alloc] initWithFrame:CGRectMake(self.view.width,64, self.view.width, self.view.height-64-49)];
    SegmentDyeingView *dyeingView = [[SegmentDyeingView alloc] initWithFrame:CGRectMake(0,0, self.view.width, self.view.height-64-49)];
    
    SegmentProcessView *processView = [[SegmentProcessView alloc]initWithFrame:CGRectMake(self.view.width,0, self.view.width, self.view.height-64-49)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+40, self.view.width, self.view.height)];
    
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    
//    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, -49, 0);
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //[tableView addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(2 *self.view.width, self.view.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:dyeingView];
    [scrollView addSubview:processView];
    _scrollView = scrollView;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    self.segment.selectedSegmentIndex = offset/self.view.width;
}

- (void)segmentClick
{
    self.scrollView.contentOffset = CGPointMake(self.segment.selectedSegmentIndex * self.view.width, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
