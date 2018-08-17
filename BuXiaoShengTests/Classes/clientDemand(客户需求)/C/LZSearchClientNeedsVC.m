//
//  LZSearchClientNeedsVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  我的订单页面

#import "LZSearchClientNeedsVC.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"
#import "LZSearchBar.h"
#import "LZOrderTrackingModel.h"
#import "LZSearchClientNeedsCell.h"

@interface LZSearchClientNeedsVC ()<SGPageTitleViewDelegate,SGPageContentViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate,LZSearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *_startStr;//开始时间
    NSString *_endStr;//结束时间
}
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property(nonatomic,strong)UIView *bottomView;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UILabel *headerLbl;
@property(nonatomic,strong)NSArray<LZOrderTrackingModel*> *lists;
@end

@implementation LZSearchClientNeedsVC

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
    self.navigationItem.titleView = [Utility navTitleView:@"我的订单"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationScreenClick) image:IMAGE(@"screenDate")];
    
    _startStr = @"";
    _endStr = @"";
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.placeholderColor = [UIColor colorWithHexString:@"#cccccc"];
    self.searchBar.textFieldBackgroundColor = [UIColor colorWithHexString:@"#e6e6ed"];
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    //    [self.view addSubview:self.searchBar];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerLbl = [[UILabel alloc]initWithFrame:_headerView.bounds];
    _headerLbl.text = @"   全部订单";
    _headerLbl.textAlignment = NSTextAlignmentLeft;
    _headerLbl.textColor = CD_Text99;
    _headerLbl.font = FONT(13);
    [_headerView addSubview:_headerLbl];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _headerView.bottom-0.5, APPWidth, 0.5)];
    lineView.backgroundColor = LZHBackgroundColor;
    [_headerView addSubview:lineView];
    //    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.and.right.equalTo(self.view);
    //        make.height.mas_offset(0.5);
    //        make.bottom.equalTo(_headerView.mas_bottom).offset(-0.5);
    //    }];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.and.right.and.bottom.equalTo(self.view);
    //        make.top.equalTo(self.searchBar.mas_bottom);
    //    }];
}

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

#pragma mark ---- 网络请求 ----
- (void)setupList{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"endDate":_endStr,
                            @"startDate":_startStr,
                            };
    [BXSHttp requestGETWithAppURL:@"sale/need_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!= 200) {
            return ;
        }
        _lists = [LZOrderTrackingModel LLMJParse:baseModel.data];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
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
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZSearchClientNeedsCellid";
    LZSearchClientNeedsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZSearchClientNeedsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    
}

#pragma mark --- 点击事件 ---
//点击日历确定
- (void)didaffirmBtnInCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = [BXSTools stringFromTData:StartStr];
    _endStr = [BXSTools stringFromTData:EndStr];
    _bottomView.hidden = YES;
    [self setupList];
    _headerLbl.textColor = CD_Text33;
    
    if (![_startStr isEqualToString:@"0"]) {
        _headerLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
    }else{
        _headerLbl.text = [NSString stringWithFormat:@"    %@",_endStr];
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
        _headerLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _headerLbl.textColor = CD_Text33;
    }else{
        _headerLbl.text = _endStr;
        _headerLbl.textColor = CD_Text33;
    }
}

//点击月历确定
- (void)didaffirmBtnInMonthCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupList];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        _headerLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _headerLbl.textColor = CD_Text33;
    }else{
        _headerLbl.text = _endStr;
        _headerLbl.textColor = CD_Text33;
    }
}

//点击季度确定
- (void)didaffirmBtnInQuarterCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupList];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        _headerLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _headerLbl.textColor = CD_Text33;
    }else{
        _headerLbl.text = _endStr;
        _headerLbl.textColor = CD_Text33;
    }
}

//点击日历取消
- (void)didCancelBtnInCalendar{
    _bottomView.hidden = YES;
}

///出现日历选择器
- (void)navigationScreenClick
{
    _bottomView.hidden = NO;
}

- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
