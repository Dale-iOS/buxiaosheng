//
//  WaitOutOrderViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  待出库（销售）

#import "WaitOutOrderViewController.h"
#import "OrderTableViewCell.h"
#import "LZOrderTrackingModel.h"
#import "LZPurchasingInfoVC.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"

@interface WaitOutOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableViewCellDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate>
{
    UIView *_headerView;
    UILabel *_timeLabel;
    UITableView *_tableView;
    UIView *_rightHeadView;
    NSInteger _page;
    NSString *_startStr;//开始时间
    NSString *_endStr;//结束时间
}
@property(nonatomic,strong)NSArray<LZOrderTrackingModel *> *lists;
@property(nonatomic,strong)SGPageTitleView *pageTitleView;
@property(nonatomic,strong)SGPageContentView *pageContentView;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation WaitOutOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI
{
    _startStr = @"";
    _endStr = @"";
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.frame = CGRectMake(15, 12, APPWidth/2, 14);
    _timeLabel.text = @"全部";
    _timeLabel.font = FONT(13);
    _timeLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    [_headerView addSubview:_timeLabel];
    
    _rightHeadView = [[UIView alloc]initWithFrame:CGRectMake(APPWidth/2, 0, APPWidth/2, 34)];
    _rightHeadView.backgroundColor = [UIColor clearColor];
    [_headerView addSubview:_rightHeadView];
    
    //筛选图标
    UIImageView *screenImageView = [[UIImageView alloc]init];
    screenImageView.image = IMAGE(@"screen");
    screenImageView.backgroundColor = [UIColor clearColor];
    [_rightHeadView addSubview:screenImageView];
    screenImageView.sd_layout
    .rightSpaceToView(_rightHeadView, 15)
    .centerYEqualToView(_rightHeadView)
    .widthIs(14)
    .heightIs(12);
    
    //筛选文字
    UILabel *screenLabel = [[UILabel alloc]init];
    screenLabel.font = FONT(13);
    screenLabel.text = @"筛选";
    screenLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    [_rightHeadView addSubview:screenLabel];
    screenLabel.sd_layout
    .rightSpaceToView(screenImageView, 4)
    .centerYEqualToView(_rightHeadView)
    .widthIs(28)
    .heightIs(14);
    
    UIButton *screenBtn = [UIButton new];
    screenBtn.backgroundColor = [UIColor clearColor];
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_rightHeadView addSubview:screenBtn];
    screenBtn.sd_layout
    .leftEqualToView(screenLabel)
    .rightSpaceToView(_rightHeadView, 0)
    .topSpaceToView(_rightHeadView, 0)
    .bottomSpaceToView(_rightHeadView, 0);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -LLNavViewHeight-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    _tableView.tableHeaderView = _headerView;
    
    [self.view addSubview:_tableView];
    
}

- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"startDate":_startStr,
                             @"endDate":_endStr
                             };
    [BXSHttp requestGETWithAppURL:@"sale/out_storage_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZOrderTrackingModel LLMJParse:baseModel.data];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
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
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"OrderTableViewCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

//采购信息按钮点击事件
- (void)didClickProcurementInfoBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [_tableView indexPathForCell:cell];
    LZOrderTrackingModel *model = _lists[indexP.row];
    
    LZPurchasingInfoVC *vc = [[LZPurchasingInfoVC alloc]init];
    vc.orderId = model.id;
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
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
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
    /// pageContentView
    //    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, 350) parentVC:self childVCs:childArr];
    _pageContentView.delegatePageContentView = self;
    //    [self.view addSubview:_pageContentView];
    
    
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
- (void)screenBtnClick{
    _bottomView.hidden = NO;
}

//点击日历确定
- (void)didaffirmBtnInCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = [BXSTools stringFromTData:StartStr];
    _endStr = [BXSTools stringFromTData:EndStr];
    _bottomView.hidden = YES;
    [self setupData];
    if (![_startStr isEqualToString:@"0"]) {
        _timeLabel.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _timeLabel.textColor = CD_Text33;
    }else{
        _timeLabel.text = _endStr;
        _timeLabel.textColor = CD_Text33;
    }
}

//点击周历确定
- (void)didaffirmBtnInWeekCalendarWithSelectArray:(NSMutableArray *)weekArray{
    NSString *str1 = [NSString stringWithFormat:@"%@",[weekArray firstObject]];
    NSString *str2 = [NSString stringWithFormat:@"%@",[weekArray lastObject]];
    
    _startStr = [BXSTools stringFromTData:str1];
    _endStr = [BXSTools stringFromTData:str2];
    [self setupData];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        _timeLabel.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _timeLabel.textColor = CD_Text33;
    }else{
        _timeLabel.text = _endStr;
        _timeLabel.textColor = CD_Text33;
    }
}

//点击月历确定
- (void)didaffirmBtnInMonthCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupData];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        _timeLabel.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _timeLabel.textColor = CD_Text33;
    }else{
        _timeLabel.text = _endStr;
        _timeLabel.textColor = CD_Text33;
    }
}

//点击季度确定
- (void)didaffirmBtnInQuarterCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupData];
    _bottomView.hidden = YES;
    if (![_startStr isEqualToString:@"0"]) {
        _timeLabel.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
        _timeLabel.textColor = CD_Text33;
    }else{
        _timeLabel.text = _endStr;
        _timeLabel.textColor = CD_Text33;
    }
}

//点击日历取消
- (void)didCancelBtnInCalendar{
    _bottomView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
