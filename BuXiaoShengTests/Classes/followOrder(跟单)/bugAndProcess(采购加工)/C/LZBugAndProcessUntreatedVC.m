//
//  LZBugAndProcessUntreatedVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购加工页面

#import "LZBugAndProcessUntreatedVC.h"
#import "LZBugAndProcessUntreatedView.h"
#import "LZBugAndProcessBssView.h"
#import "LZDidBugAndProcessUntreatedVC.h"

@interface LZBugAndProcessUntreatedVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UISegmentedControl *sgc;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)LZBugAndProcessUntreatedView *untreatedView;//销售
@property(nonatomic,strong)LZBugAndProcessBssView *bossView;//老板
@end

@implementation LZBugAndProcessUntreatedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.navigationItem.titleView = [Utility navTitleView:@"采购加工"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"new_lists")];
    
    UIView *bgSgcView = [[UIView alloc]init];
    bgSgcView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgSgcView];
    [bgSgcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(45);
    }];
    
    //s设置分段选择器
    _sgc = [[UISegmentedControl alloc]initWithItems:@[@"销售",@"老板"]];
    _sgc.selectedSegmentIndex = 0;
    _sgc.tintColor = LZAppBlueColor;
    [_sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [bgSgcView addSubview:_sgc];
    [_sgc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.width.mas_offset(180);
        make.centerX.equalTo(bgSgcView);
        make.centerY.equalTo(bgSgcView);
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
        make.top.equalTo(bgSgcView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    _untreatedView = [[LZBugAndProcessUntreatedView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -LLNavViewHeight -bgSgcView.height)];
    [_scrollView addSubview:_untreatedView];
   
    _bossView = [[LZBugAndProcessBssView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight -LLNavViewHeight -bgSgcView.height)];
    [_scrollView addSubview:_bossView];
}


#pragma mark ----- 点击事件 -----
//导航栏右按钮点击事件
- (void)navigationSetupClick{
    LZDidBugAndProcessUntreatedVC *vc = [[LZDidBugAndProcessUntreatedVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
