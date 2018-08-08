//
//  BankDetailListViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行明细页面2

#import "BankDetailListViewController.h"
#import "BankDetailListTableViewCell.h"
#import "DocumentBankDetailViewController.h"
//#import "LZBankListDetailModel.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"
#import "LZChooseBankTypeVC.h"
#import "LZBankListModel.h"

static NSInteger const pageSize = 10;

@interface BankDetailListViewController ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate,SGPageContentViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate>
{
    NSString *_startStr;//开始时间
    NSString *_endStr;//结束时间
    NSString *_bankId;//银行id
    NSString *_incometypeId;//消费id
    UILabel *_totalExpenditure;//总支出
    UILabel *_totalIncome;//总收入
}
@property (nonatomic, strong) UIView *tableViewHeadView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *headDateLbl;
@property(nonatomic,strong) NSMutableArray <LZBankListListModel *> *lists;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property(nonatomic,strong)UIView *bottomView;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@property (nonatomic, strong) UIView *bottomView2;//底布显示总收入和总支出
@end

@implementation BankDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI
{
    self.pageIndex = 1;
    
    //tableview顶部试图
    self.tableViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.tableViewHeadView.backgroundColor = [UIColor whiteColor];
    
    _startStr = @"";
    _endStr = @"";
    _bankId = @"";
    _incometypeId = @"";
//    _typeId = @"";
    
    //日期
    self.headDateLbl = [[UILabel alloc]init];
    self.headDateLbl.text = @"全部";
    self.headDateLbl.textAlignment = NSTextAlignmentRight;
    self.headDateLbl.textColor = CD_Text66;
    self.headDateLbl.font = FONT(13);
    [self.tableViewHeadView addSubview:self.headDateLbl];
    
    UIButton *dateBtn = [[UIButton alloc]init];
    [dateBtn setImage:IMAGE(@"bankdate") forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(dateBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [dateBtn setBackgroundColor:[UIColor clearColor]];
    [self.tableViewHeadView addSubview:dateBtn];
    
    //线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [self.tableViewHeadView addSubview:lineView];
    
    dateBtn.sd_layout
    .rightSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView)
    .widthIs(16)
    .heightIs(16);
    
    self.headDateLbl.sd_layout
    .rightSpaceToView(dateBtn, 10)
    .centerYEqualToView(self.tableViewHeadView)
    .heightIs(15)
    .widthIs(200);
    
    lineView.sd_layout
    .bottomSpaceToView(self.tableViewHeadView, -1)
    .heightIs(1)
    .widthIs(APPWidth)
    .leftSpaceToView(self.tableViewHeadView, 0);
    
    self.navigationItem.titleView = [Utility navTitleView:@"银行明细"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"screen1")];

    self.view.backgroundColor = LZHBackgroundColor;
    
    _bottomView2 = [[UIView alloc]init];
    _bottomView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView2];
    [_bottomView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.width.mas_offset(APPWidth);
        make.height.mas_offset(44);
    }];
    _totalExpenditure = [[UILabel alloc]init];
    _totalExpenditure.font = FONT(13);
    _totalExpenditure.textAlignment = NSTextAlignmentCenter;
    _totalExpenditure.textColor = CD_Text33;
    [_bottomView2 addSubview:_totalExpenditure];
    [_totalExpenditure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.mas_equalTo(_bottomView2);
        make.width.mas_offset(APPWidth/2);
    }];
    _totalIncome = [[UILabel alloc]init];
    _totalIncome.font = FONT(13);
    _totalIncome.textAlignment = NSTextAlignmentCenter;
    _totalIncome.textColor = CD_Text33;
    [_bottomView2 addSubview:_totalIncome];
    [_totalIncome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.mas_equalTo(_bottomView2);
        make.width.mas_offset(APPWidth/2);
    }];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.tableViewHeadView;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(_bottomView2.mas_top);
    }];
    
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf setupList];
    }];
    
}

- (MJRefreshFooter *)reloadMoreData {
    WEAKSELF;
    MJRefreshFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex +=1;
        [weakSelf setupList];
    }];
    return footer;
}

#pragma mark ---- 网络请求 ----
- (void)setupList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
                             @"startDate":_startStr,
                             @"endDate":_endStr,
                             @"type":_typeId == nil ? @"" : _typeId,
                             @"bankId":_bankId == nil ? @"" : _bankId,
                             @"incomeType":_incometypeId == nil ? @"" : _incometypeId
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/bank_detail_list.do" param:param success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [[response objectForKey:@"data"] objectForKey:@"itemList"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZBankListListModel *model = [LZBankListListModel mj_objectWithKeyValues:dic];
                    [self.lists addObject:model];
                }
                if (self.lists.count % pageSize) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
            } else {
                [LLHudTools showWithMessage:@"暂无更多数据"];
            }
            if (self.pageIndex == 1) {
                if (self.lists.count >= pageSize) {
                    self.tableView.mj_footer = [self reloadMoreData];
                } else {
                    self.tableView.mj_footer = nil;
                }
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } else {
            [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        _totalExpenditure.text = [NSString stringWithFormat:@"总收入：%@",[[response objectForKey:@"data"] objectForKey:@"totalExpenditure"]];
        _totalIncome.text = [NSString stringWithFormat:@"总支出：%@",[[response objectForKey:@"data"] objectForKey:@"totalIncome"]];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"BankDetailListTableViewCell";
    
    BankDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[BankDetailListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DocumentBankDetailViewController *vc = [[DocumentBankDetailViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navigationSetupClick{

    LZChooseBankTypeVC *vc = [[LZChooseBankTypeVC alloc]init];
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    [vc setSelectIDBlock:^(NSString *typeId, NSString *bankId, NSString *incomeId) {
        _typeId = typeId;
        _bankId = bankId;
        _incometypeId = incomeId;
    }];
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
    _bottomView.hidden = YES;
    
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
    _startStr = [BXSTools stringFromTData:StartStr];
    _endStr = [BXSTools stringFromTData:EndStr];
    _bottomView.hidden = YES;
    [self setupList];
    if (![_startStr isEqualToString:@"0"]) {
        self.headDateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
    }else{
        self.headDateLbl.text = _endStr;
    }
}

//点击周历确定
- (void)didaffirmBtnInWeekCalendarWithSelectArray:(NSMutableArray *)weekArray{
    NSString *str1 = [NSString stringWithFormat:@"%@",[weekArray firstObject]];
    NSString *str2 = [NSString stringWithFormat:@"%@",[weekArray lastObject]];
    
    _startStr = [BXSTools stringFromTData:str1];
    _endStr = [BXSTools stringFromTData:str2];
    [self setupList];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        self.headDateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        self.headDateLbl.textColor = CD_Text33;
    }else{
        self.headDateLbl.text = _endStr;
        self.headDateLbl.textColor = CD_Text33;
    }
}

//点击月历确定
- (void)didaffirmBtnInMonthCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupList];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        self.headDateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        self.headDateLbl.textColor = CD_Text33;
    }else{
        self.headDateLbl.text = _endStr;
        self.headDateLbl.textColor = CD_Text33;
    }
}

//点击季度确定
- (void)didaffirmBtnInQuarterCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupList];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        self.headDateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        self.headDateLbl.textColor = CD_Text33;
    }else{
        self.headDateLbl.text = _endStr;
        self.headDateLbl.textColor = CD_Text33;
    }
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

#pragma mark - Getter && Setter
- (NSMutableArray<LZBankListListModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}


@end
