//
//  BankDetailListViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行明细页面2

#import "BankDetailListViewController.h"
#import "BankDetailListTableViewCell.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"
#import "LZChooseBankTypeVC.h"

#import "LLBankDetailListChildVc.h"
@interface BankDetailListViewController ()<UIScrollViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate>
@property (nonatomic, strong) UIView *tableViewHeadView;

@property(nonatomic ,strong)UIView * titleView;
@property(nonatomic ,strong)UIView * titleLineView;
@property(nonatomic ,strong)UILabel * seletedTimeLable;
@property(nonatomic ,strong)UIScrollView * contentScrollView;
@property(nonatomic ,strong)NSArray <NSString*> * titles;
@property(nonatomic ,strong)NSMutableArray <UIButton *>* buttons;
@property(nonatomic ,strong)UIView * bottomView;
@property(nonatomic ,strong)SGPageTitleView * pageTitleView;
@property(nonatomic ,strong)SGPageContentView * pageContentView;
@property(nonatomic ,assign)NSInteger  scrollIndex;
@end

@implementation BankDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
//    [self setupPageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self setupList];
}

- (void)setupUI
{
    self.title = @"银行明细";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"screen1"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.view addSubview:self.tableViewHeadView];
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.tableViewHeadView.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.contentScrollView];
  
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
    UIView * scrollViewContainerView = [UIView new];
    [self.contentScrollView addSubview:scrollViewContainerView];
    [scrollViewContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentScrollView);
        make.height.equalTo(self.contentScrollView);
    }];
    for (int i = 0; i<self.titles.count; i++) {
        LLBankDetailListChildVc * detailListVc = [LLBankDetailListChildVc new];
         detailListVc.bankId = self.typeId;
        if (i == 0) {
            detailListVc.dateType = 1;
        }
        [scrollViewContainerView addSubview:detailListVc.view];
        [self addChildViewController:detailListVc];
        [detailListVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollViewContainerView).offset(SCREEN_WIDTH*i);
        make.top.bottom.equalTo(scrollViewContainerView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        }];
       
    }
    [scrollViewContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.childViewControllers.lastObject.view.mas_right);
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / APPWidth;
    LLBankDetailListChildVc * childVc = self.childViewControllers[index];
    childVc.dateType = index+1;
    [self titleBtnClick:self.buttons[index]];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}


#pragma mark --- 日历 ---
//初始化日历
- (void)setupPageView {
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }

    NSArray *titleArr = @[@"日历",@"周历",@"月历",@"季度"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = MAXFLOAT; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleSelectedColor = RGB(59, 177, 239);
    configure.indicatorColor = RGB(59, 177, 239);;

    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];

    LLDayCalendarVc *dayVC = [[LLDayCalendarVc alloc] init];
    dayVC.delegate = self;
    LLWeekCalendarVc *weekVC = [[LLWeekCalendarVc alloc] init];
    weekVC.delegate = self;
    LLMonthCalendarVc *monthVC = [[LLMonthCalendarVc alloc] init];
    monthVC.delegate = self;
    LLQuarterCalendarVc *quarterVC = [[LLQuarterCalendarVc alloc] init];
    quarterVC.delegate = self;

    NSArray *childArr = @[dayVC, weekVC, monthVC, quarterVC];

    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, 350) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;

    _bottomView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bottomView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    _bottomView.hidden = false;

    [_bottomView addSubview:_pageTitleView];
    [_bottomView addSubview:_pageContentView];
    [self.view addSubview:_bottomView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}


//点击日历确定
- (void)didaffirmBtnInCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    LLBankDetailListChildVc * currentcChildVc = self.childViewControllers[self.scrollIndex];
    _bottomView.hidden = YES;
    if (![StartStr isEqualToString:@"0"]) {
        currentcChildVc.startDate = [BXSTools stringFromTData:StartStr];
        currentcChildVc.endDate = [BXSTools stringFromTData:EndStr];
        self.seletedTimeLable.text = [NSString stringWithFormat:@"    %@ 至 %@",currentcChildVc.startDate,currentcChildVc.endDate];
    }else{
        currentcChildVc.startDate = [BXSTools stringFromTData:EndStr];
        currentcChildVc.endDate = [BXSTools stringFromTData:EndStr];
        self.seletedTimeLable.text = currentcChildVc.endDate;
    }
     currentcChildVc.dateType = self.scrollIndex+1;
}

//点击周历确定
- (void)didaffirmBtnInWeekCalendarWithSelectArray:(NSMutableArray *)weekArray{
    NSString *str1 = [NSString stringWithFormat:@"%@",[weekArray firstObject]];
    NSString *str2 = [NSString stringWithFormat:@"%@",[weekArray lastObject]];
    
    LLBankDetailListChildVc * currentcChildVc = self.childViewControllers[self.scrollIndex];
    currentcChildVc.startDate = [BXSTools stringFromTData:str1];
    currentcChildVc.endDate = [BXSTools stringFromTData:str2];
     currentcChildVc.dateType = self.scrollIndex+1;
    _bottomView.hidden = YES;
 self.seletedTimeLable.text = [NSString stringWithFormat:@"    %@ 至 %@",currentcChildVc.startDate,currentcChildVc.endDate];

}

//点击月历确定
-(void)didaffirmBtnInMonthCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr {
    LLBankDetailListChildVc * currentcChildVc = self.childViewControllers[self.scrollIndex];
    currentcChildVc.startDate = StartStr;
    currentcChildVc.endDate = EndStr;
    currentcChildVc.dateType = self.scrollIndex+1;
    _bottomView.hidden = YES;
    self.seletedTimeLable.text = [NSString stringWithFormat:@"    %@ 至 %@",currentcChildVc.startDate,currentcChildVc.endDate];
}


//点击季度确定
- (void)didaffirmBtnInQuarterCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    LLBankDetailListChildVc * currentcChildVc = self.childViewControllers[self.scrollIndex];
    currentcChildVc.startDate = StartStr;
    currentcChildVc.endDate = EndStr;
    currentcChildVc.dateType = self.scrollIndex+1;
    _bottomView.hidden = YES;
    self.seletedTimeLable.text = [NSString stringWithFormat:@"    %@ 至 %@",currentcChildVc.startDate,currentcChildVc.endDate];
//    _startStr = StartStr;
//    _endStr = EndStr;
//    [self setupList];
//    _bottomView.hidden = YES;
//    if (![_startStr isEqualToString:@"0"]) {
//        self.headDateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
//        self.headDateLbl.textColor = CD_Text33;
//    }else{
//        self.headDateLbl.text = _endStr;
//        self.headDateLbl.textColor = CD_Text33;
//    }
}

//点击日历取消
- (void)didCancelBtnInCalendar{
    _bottomView.hidden = YES;
}

//点击选择日期按钮
- (void)dateBtnOnClick
{
   _bottomView.hidden = NO;
}
/// MARK: ---- 导航右边的点击时间
-(void)rightBarButtonItemClick {
   
        LZChooseBankTypeVC *vc = [[LZChooseBankTypeVC alloc]init];
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
        [vc setSelectIDBlock:^(NSString *typeId, NSString *bankId, NSString *incomeId) {
            LLBankDetailListChildVc * currentcChildVc = self.childViewControllers[self.scrollIndex];
             currentcChildVc.dateType = [typeId integerValue];
             currentcChildVc.bankId = bankId;
             currentcChildVc.incomeId = incomeId;
             currentcChildVc.dateType = self.scrollIndex+1;
             currentcChildVc.type = typeId;
        }];

}
/// MARK: ---- 日历按钮的点击方法
-(void)seletedTimeIvClick{
    [self setupPageView];
}
/// MARK: ---- 本月 本日 季度 年 点击方法
-(void)titleBtnClick:(UIButton*)btn {
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton*)obj;
            btn.selected = false;
        }
    }];
     btn.selected = true;
    CGFloat width = SCREEN_WIDTH/2/4;
   
    [UIView animateWithDuration:0.25 animations:^{
         [self.titleView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.titleLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_titleView).offset(width*btn.tag+width/4);
        }];
    }];
    self.scrollIndex = btn.tag;
    [self.contentScrollView setContentOffset:CGPointMake(APPWidth * btn.tag, 0) animated:true];
}

-(NSString *)setupToyDay {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

#pragma mark - Getter && Setter
-(UIView *)titleView {
    if (!_titleView) {
        _titleView = [UIView new];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titles = @[@"本日",@"本月",@"本季度",@"本年"];
        CGFloat width = SCREEN_WIDTH/2/4;
        _buttons = [NSMutableArray array];
        [_titles enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton * btn = [UIButton new];
            [self->_buttons addObject:btn];
            btn.tag = idx;
            [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTitleColor:LZAppBlueColor forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor darkGrayColor ] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [self->_titleView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self->_titleView).offset(width*idx);
                make.centerY.equalTo(self->_titleView);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(35);
            }];
            if (idx == 0) {
                btn.selected = true;
                self.titleLineView = [UIView new];
                [self->_titleView addSubview:self.titleLineView];
                self.titleLineView.backgroundColor = LZAppBlueColor;
                [self.titleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(width/2);
                    make.left.equalTo(self->_titleView).offset(width*btn.tag+width/4);
                    make.top.equalTo(self->_titleView).offset(36);
                    make.height.mas_equalTo(2);
                }];
            }
        }];
        UIImageView * seletedTimeIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bankdate"]];
        addGestureRecognizer(seletedTimeIv, seletedTimeIvClick)
        [_titleView addSubview:seletedTimeIv];
        [seletedTimeIv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self->_titleView).offset(-15);
            make.centerY.equalTo(self->_titleView);
        }];
        self.seletedTimeLable = [UILabel new];
        self.seletedTimeLable.text = [self setupToyDay];
         [_titleView addSubview:self.seletedTimeLable];
        self.seletedTimeLable.font = [UIFont systemFontOfSize:14];
        self.seletedTimeLable.textColor = [UIColor darkGrayColor];
        [self.seletedTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(seletedTimeIv.mas_left).offset(-10);
            make.centerY.equalTo(self->_titleView);
        }];
        UIView * lineView = [UIView new];
        [_titleView addSubview:lineView];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self->_titleView);
            make.height.mas_equalTo(0.8);
        }];
    }
    return _titleView;
}
-(UIView *)tableViewHeadView {
    if (!_tableViewHeadView) {
        _tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, LLNavViewHeight, SCREEN_WIDTH, 231-LLNavViewHeight)];
        _tableViewHeadView.backgroundColor = [UIColor whiteColor];
        //总收入的背景
        UIImageView * leftBgIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"totalRevenue"]];
        [_tableViewHeadView addSubview:leftBgIv];
        [leftBgIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_tableViewHeadView).offset(15);
            make.top.equalTo(self->_tableViewHeadView).offset(20);
            make.bottom.equalTo(self->_tableViewHeadView).offset(-20);
            make.width.mas_equalTo((SCREEN_WIDTH-30-5)/2);
        }];
        
        UILabel * totalRevenueMsgLable = [UILabel new];
        [leftBgIv addSubview:totalRevenueMsgLable];
        totalRevenueMsgLable.textColor = [UIColor whiteColor];
        totalRevenueMsgLable.font = [UIFont systemFontOfSize:13];
        totalRevenueMsgLable.text = @"总收入 (元)";
        [totalRevenueMsgLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBgIv).offset(15);
            make.top.equalTo(leftBgIv).offset(20);
        }];
        
        self.totalRevenueMoenyLable = [UILabel new];
        [leftBgIv addSubview: self.totalRevenueMoenyLable];
         self.totalRevenueMoenyLable.textColor = [UIColor whiteColor];
         self.totalRevenueMoenyLable.font = [UIFont systemFontOfSize:18];
         self.totalRevenueMoenyLable.text = @"598,765,329.00";
        [ self.totalRevenueMoenyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBgIv).offset(15);
            make.top.equalTo(totalRevenueMsgLable.mas_bottom).offset(20);
        }];
        
        //总支出的背景
        UIImageView * rightBgIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"totalSpending"]];
        [_tableViewHeadView addSubview:rightBgIv];
        [rightBgIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBgIv.mas_right).offset(5);
            make.top.equalTo(self->_tableViewHeadView).offset(20);
            make.bottom.equalTo(self->_tableViewHeadView).offset(-20);
            make.width.mas_equalTo((SCREEN_WIDTH-30-5)/2);
        }];
        
        UILabel * totalSpendingMsgLable = [UILabel new];
        [rightBgIv addSubview:totalSpendingMsgLable];
        totalSpendingMsgLable.textColor = [UIColor whiteColor];
        totalSpendingMsgLable.font = [UIFont systemFontOfSize:13];
        totalSpendingMsgLable.text = @"总支出 (元)";
        [totalSpendingMsgLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightBgIv).offset(15);
            make.top.equalTo(rightBgIv).offset(20);
        }];
        
        self.totalSpendingMoenyLable = [UILabel new];
        [rightBgIv addSubview: self.totalSpendingMoenyLable];
        self.totalSpendingMoenyLable.textColor = [UIColor whiteColor];
        self.totalSpendingMoenyLable.font = [UIFont systemFontOfSize:18];
        self.totalSpendingMoenyLable.text = @"598,765,329.00";
        [ self.totalSpendingMoenyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightBgIv).offset(15);
            make.top.equalTo(totalSpendingMsgLable.mas_bottom).offset(20);
        }];
        
    }
    return _tableViewHeadView;
}
-(UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [UIScrollView new];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = true;
    }
    return _contentScrollView;
}



@end
