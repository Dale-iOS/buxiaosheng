//
//  LZAssignDeliveryListVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  指派送货列表页面

#import "LZAssignDeliveryListVC.h"
#import "LZAssignDeliveryListModel.h"
#import "LZAssignDeliveryCell.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"

static NSInteger const pageSize = 15;
@interface LZAssignDeliveryListVC ()<UITableViewDelegate, UITableViewDataSource,SGPageTitleViewDelegate,SGPageContentViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate>
{
    NSString *_startStr;//开始时间
    NSString *_endStr;//结束时间
}
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *dateLbl;
@property(nonatomic,strong)NSMutableArray<LZAssignDeliveryListModel*> *lists;
@property(nonatomic,strong)SGPageTitleView *pageTitleView;
@property(nonatomic,strong)SGPageContentView *pageContentView;
@property(nonatomic,strong)UIView *bottomView;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation LZAssignDeliveryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI{
    self.pageIndex = 1;
    _startStr = @"";
    _endStr = @"";
    
    self.navigationItem.titleView = [Utility navTitleView:@"指派送货列表"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(selectornavRightBtnClick) image:IMAGE(@"screenDate")];
    
    //设置tableview顶部试图
    _headView = [[UIView alloc]initWithFrame:CGRectZero];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.height.mas_offset(34);
    }];
    
    _dateLbl = [[UILabel alloc]init];
    _dateLbl.font = FONT(13);
    _dateLbl.textColor = CD_Text99;
    _dateLbl.text = @" 全部";
    [_headView addSubview:_dateLbl];
    [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView).offset(15);
        make.right.equalTo(_headView).offset(-15);
        make.height.mas_offset(14);
        make.centerY.equalTo(_headView);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [_headView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_headView);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(_headView).offset(-0.5);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    WEAKSELF;
    _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
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

#pragma mark ----- 网络请求 ------
// 接口：已发货-销售需求
- (void)setupList
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
                             @"startDate":_startStr,
                             @"endDate":_endStr
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/already_shipped_list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZAssignDeliveryListModel *model = [LZAssignDeliveryListModel mj_objectWithKeyValues:dic];
                    [self.lists addObject:model];
                }
                if (self.lists.count % pageSize) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
            } else {
                //                [LLHudTools showWithMessage:@"暂无更多数据"];
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
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark ---- tableviewDelegate ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"LZAssignDeliveryCellId";
    LZAssignDeliveryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[LZAssignDeliveryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = _lists[indexPath.row];
    return cell;
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

//点击选择日期按钮
- (void)selectornavRightBtnClick{
    _bottomView.hidden = NO;
}

//点击日历确定
- (void)didaffirmBtnInCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = [BXSTools stringFromTData:StartStr];
    _endStr = [BXSTools stringFromTData:EndStr];
    _bottomView.hidden = YES;
    [self setupList];
    if (![_startStr isEqualToString:@"0"]) {
        _dateLbl.text = [NSString stringWithFormat:@" %@ 至 %@",_startStr,_endStr];
        _dateLbl.textColor = CD_Text33;
    }else{
        _dateLbl.text = _endStr;
        _dateLbl.textColor = CD_Text33;
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
        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _dateLbl.textColor = CD_Text33;
    }else{
        _dateLbl.text = _endStr;
        _dateLbl.textColor = CD_Text33;
    }
}

//点击月历确定
- (void)didaffirmBtnInMonthCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupList];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _dateLbl.textColor = CD_Text33;
    }else{
        _dateLbl.text = _endStr;
        _dateLbl.textColor = CD_Text33;
    }
}

//点击季度确定
- (void)didaffirmBtnInQuarterCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupList];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _dateLbl.textColor = CD_Text33;
    }else{
        _dateLbl.text = _endStr;
        _dateLbl.textColor = CD_Text33;
    }
}


//点击日历取消
- (void)didCancelBtnInCalendar{
    _bottomView.hidden = YES;
}


#pragma mark - Getter && Setter
- (NSMutableArray<LZAssignDeliveryListModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
