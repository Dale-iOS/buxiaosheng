//
//  LZSearchClientNeedsVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSearchClientNeedsVC.h"
#import "LZDrawerChooseView.h"

@interface LZSearchClientNeedsVC ()<LZDrawerChooseViewDelegate>
@property (nonatomic,strong)LZDrawerChooseView *chooseView;
@property (nonatomic,strong)UIView *bottomBlackView;//侧滑的黑色底图
@end

@implementation LZSearchClientNeedsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"我的订单"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationScreenClick) image:IMAGE(@"screenDate")];
    
    _bottomBlackView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bottomBlackView.backgroundColor = [UIColor blackColor];
    _bottomBlackView.hidden = YES;
    [self.view addSubview:_bottomBlackView];
    
    [self setupChooseView];
}

- (void)setupChooseView
{
    //初始化抽屉
    _chooseView = [[LZDrawerChooseView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight)];
    _chooseView.delegate = self;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_chooseView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [_chooseView.alphaiView addGestureRecognizer:tap];
}

#pragma mark ----- 点击事件 ------
//滑出选择侧栏
- (void)navigationScreenClick
{
    _bottomBlackView.alpha = 0.65;
    _bottomBlackView.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        _chooseView .frame = CGRectMake(0, 0, APPWidth, APPHeight);
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.35 animations:^{
        _bottomBlackView.alpha = 0;
        _chooseView .frame = CGRectMake(APPWidth, 0, APPWidth, APPHeight);
        
    } completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
