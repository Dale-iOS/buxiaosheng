//
//  LZIncomeVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  收款单页面

#import "LZIncomeVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "ArrearsNameTextInputCell.h"
#import "UIView+LLXAlertPop.h"
#import "LZWeaveView.h"
#import "LZDyeView.h"
#import "LZClientReceiptVC.h"



@interface LZIncomeVC ()<LZHTableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,weak)LZHTableView *myTabelView;
@property(nonatomic,strong)NSMutableArray *dataSourse;
///名称
@property(nonatomic,strong)ArrearsNameTextInputCell *titileCell;
///收款金额
@property(nonatomic,strong)TextInputCell *collectionCell;
///现欠款
@property(nonatomic,strong)TextInputCell *arrearsCell;
///收款账户
@property(nonatomic,strong)TextInputCell *accountCell;
///备注
@property(nonatomic,strong)TextInputTextView *remarkTextView;
///灰色背景条1
@property(nonatomic,strong)UIView *lineOne;
///灰色背景条2
@property(nonatomic,strong)UIView *lineTwo;
///保存按钮
@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UISegmentedControl *sgc;
@property(nonatomic,strong)LZWeaveView *weaveView;
@property(nonatomic,strong)LZDyeView *dyeView;

@end

@implementation LZIncomeVC
@synthesize myTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (LZHTableView *)myTabelView{
    if (myTabelView == nil) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64+40, APPWidth, APPHeight)];
        tableView.delegate = self;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(myTabelView = tableView)];
    }
    return myTabelView;
}

- (void)setupSgc{
    
    _sgc = [[UISegmentedControl alloc]initWithItems:@[@"客户收款单",@"调整金额"]];
    _sgc.selectedSegmentIndex = 0;
    _sgc.tintColor = LZAppBlueColor;
    [_sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sgc];
    [_sgc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight +10);
        make.height.mas_offset(30);
        make.width.mas_offset(180);
        make.centerX.equalTo(self.view);
    }];
    
    //保存按钮
//    _saveBtn = [UIButton new];
//    _saveBtn.backgroundColor = LZAppBlueColor;
//    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [_saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
//    _saveBtn.titleLabel.textColor = [UIColor whiteColor];
//    [self.view addSubview:_saveBtn];
//    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.and.left.and.right.equalTo(self.view);
//        make.height.mas_offset(45);
//    }];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(APPWidth *2, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sgc.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    _weaveView = [[LZWeaveView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight - LLNavViewHeight -50)];
    [_scrollView addSubview:_weaveView];
    
    _dyeView = [[LZDyeView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight - LLNavViewHeight -50)];
    [_scrollView addSubview:_dyeView];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"收款单"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationRightClick) image:IMAGE(@"new_lists")];
    
    [self setupSgc];
}



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

- (void)navigationRightClick{
    LZClientReceiptVC *vc = [[LZClientReceiptVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)saveBtnOnClickAction{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
