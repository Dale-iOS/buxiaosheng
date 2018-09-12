//
//  DidOutOrderViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  已出库（销售）

#import "DidOutOrderViewController.h"
#import "LZOrderTrackingModel.h"
#import "DidOutInventoryCell.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"
#import "LZOutOrderDetailVC.h"

static NSInteger const pageSize = 15;
@interface DidOutOrderViewController ()<UITableViewDelegate,UITableViewDataSource,DidOutInventoryCellDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate>
{
    UIView *_headerView;
    UILabel *_timeLabel;
    UIView *_rightHeadView;
    NSInteger _page;
    NSString *_startStr;//开始时间
    NSString *_endStr;//结束时间
}
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<LZOrderTrackingModel*> *lists;
@property(nonatomic,strong)SGPageTitleView *pageTitleView;
@property(nonatomic,strong)SGPageContentView *pageContentView;
@property(nonatomic,strong)UIView *bottomView;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation DidOutOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPageView];
    
    if (!IOS11Later) {
        [self setupList];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI
{
    
    self.pageIndex = 1;
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

#pragma mark ---- 网络请求 ----
- (void)setupList
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
                             @"startDate":_startStr,
                             @"endDate":_endStr
                             };
    [BXSHttp requestGETWithAppURL:@"sale/already_storage_list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZOrderTrackingModel *model = [LZOrderTrackingModel mj_objectWithKeyValues:dic];
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
    return 143;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"DidOutInventoryCellId";
    DidOutInventoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[DidOutInventoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LZOrderTrackingModel *model = _lists[indexPath.row];
    LZOutOrderDetailVC *vc = [[LZOutOrderDetailVC alloc]init];
    vc.orderId = model.orderNo;
    vc.title = @"仓库出库详情";
    [self.navigationController pushViewController:vc animated:YES];
}

//收货按钮事件
- (void)didClickreceivingBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [_tableView indexPathForCell:cell];
    LZOrderTrackingModel *model = _lists[indexP.row];
    
    //设置警告框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认点击收货？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"取消执行");
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //        确定的执行事件
        //        接口名称 收货
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"orderId":model.id
                                 };
        [BXSHttp requestGETWithAppURL:@"sale/collect_goods.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"提交成功"];
            [self setupList];
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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

    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
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
- (void)screenBtnClick{
    _bottomView.hidden = NO;
}

//点击日历确定
- (void)didaffirmBtnInCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = [BXSTools stringFromTData:StartStr];
    _endStr = [BXSTools stringFromTData:EndStr];
    _bottomView.hidden = YES;
    [self setupList];
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
    [self setupList];
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
    [self setupList];
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
    [self setupList];
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

#pragma mark - Getter && Setter
- (NSMutableArray<LZOrderTrackingModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

