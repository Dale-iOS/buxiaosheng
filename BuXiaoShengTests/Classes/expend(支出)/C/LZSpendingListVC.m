//
//  LZSpendingListVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  日常支出列表页面

#import "LZSpendingListVC.h"
#import "LZSpendingListCell.h"
#import "LZSpendingModel.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"
#import "LZSearchBar.h"
#import "LZAuditDetailVC.h"

static NSInteger const pageSize = 15;

@interface LZSpendingListVC ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate,SGPageContentViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate,LZSearchBarDelegate>
{
    NSString *_startStr;//开始时间
    NSString *_endStr;//结束时间
}
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *rigthHeadView;
@property(nonatomic,strong)UILabel *dateLbl;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<LZSpendingDetailModel*> *lists;
@property(nonatomic,strong)SGPageTitleView *pageTitleView;
@property(nonatomic,strong)SGPageContentView *pageContentView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)LZSearchBar * searchBar;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation LZSpendingListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupListData];
}

- (void)setupUI{
    self.pageIndex = 1;
    
    self.navigationItem.titleView = [Utility navTitleView:@"日常支出列表"];
    _startStr = @"";
    _endStr = @"";
    
    //初始化搜索框
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.placeholderColor = [UIColor colorWithHexString:@"#cccccc"];
    self.searchBar.textFieldBackgroundColor = [UIColor colorWithHexString:@"#e6e6ed"];
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    //设置顶部时间筛选
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(39);
    }];
    
    _rigthHeadView = [[UIView alloc]init];
    _rigthHeadView.backgroundColor = [UIColor whiteColor];
    _rigthHeadView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapClick)];
    [_rigthHeadView addGestureRecognizer:headerTap];
    [_headView addSubview:_rigthHeadView];
    [_rigthHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headView);
        make.top.and.bottom.equalTo(_headView);
        make.width.mas_offset(140);
    }];
    UIImageView *dateImageView = [[UIImageView alloc]init];
    dateImageView.image = IMAGE(@"bankdate");
    [_rigthHeadView addSubview:dateImageView];
    [dateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(16);
        make.height.mas_offset(15);
        make.right.equalTo(_rigthHeadView).offset(-15);
        make.centerY.equalTo(_rigthHeadView);
    }];
    _dateLbl = [[UILabel alloc]init];
    _dateLbl.textColor = CD_Text66;
    _dateLbl.font = FONT(14);
    _dateLbl.text = @"全部";
    _dateLbl.textAlignment = NSTextAlignmentRight;
    [_rigthHeadView addSubview:_dateLbl];
    [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(200);
        make.height.mas_offset(15);
        make.right.equalTo(dateImageView.mas_left).offset(-10);
        make.centerY.equalTo(dateImageView);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom).offset(0.5);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    WEAKSELF;
    _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf setupListData];
    }];
}

- (MJRefreshFooter *)reloadMoreData {
    WEAKSELF;
    MJRefreshFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex +=1;
        [weakSelf setupListData];
    }];
    return footer;
}

#pragma mark ----- 网络请求 -----
- (void)setupListData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
                             @"startDate":_startStr,
                             @"endDate":_endStr,
                             @"searchName":self.searchBar.text
                             };
    [BXSHttp requestGETWithAppURL:@"finance/expend_list.do" param:param success:^(id response) {
//        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
//        if ([baseModel.code integerValue] != 200) {
//            [LLHudTools showWithMessage:baseModel.msg];
//            return ;
//        }
//        _lists = [LZSpendingDetailModel LLMJParse:baseModel.data];
//        [_tableView reloadData];
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
        NSArray *itemList = [response objectForKey:@"data"];
        if (itemList && itemList.count > 0) {
            for (NSDictionary *dic in itemList) {
                LZSpendingDetailModel *model = [LZSpendingDetailModel mj_objectWithKeyValues:dic];
                [self.lists addObject:model];
            }
            if (self.lists.count % pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
        } else {
//            [LLHudTools showWithMessage:@"暂无更多数据"];
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
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZSpendingListCellid";
    LZSpendingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZSpendingListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZSpendingDetailModel *model = _lists[indexPath.row];
    
    LZAuditDetailVC *vc = [[LZAuditDetailVC alloc]init];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];

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
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:_pageTitleView];
    
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
- (void)headerTapClick{
    _bottomView.hidden = NO;
}
//点击日历确定
- (void)didaffirmBtnInCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = [BXSTools stringFromTData:StartStr];
    _endStr = [BXSTools stringFromTData:EndStr];
    _bottomView.hidden = YES;
    [self setupListData];
    if (![_startStr isEqualToString:@"0"]) {
        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
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
    [self setupListData];
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
    [self setupListData];
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
    [self setupListData];
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

- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (self.searchBar.text.length < 1) {
        return;
    }
    [self setupListData];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZSpendingDetailModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
