//
//  CustomerReconciliationViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户对账表页面

#import "CustomerReconciliationViewController.h"
#import "CustomerReconciliationTableViewCell.h"
#import "UITextField+PopOver.h"
#import "LZCheckReceiptModel.h"
#import "LZCollectionCheckVC.h"
#import "LLDayCalendarVc.h"
#import "LLWeekCalendarVc.h"
#import "LLMonthCalendarVc.h"
#import "LLQuarterCalendarVc.h"
#import "SGPagingView.h"

@interface CustomerReconciliationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SGPageTitleViewDelegate,SGPageContentViewDelegate,LLDayCalendarVcDelegate,LLWeekCalendarVcDelegate,LLMonthCalendarVcDelegate,LLQuarterCalendarVcVcDelegate>
{
    NSString *_startStr;//开始时间
    NSString *_endStr;//结束时间
    NSString *_arrear;//欠款金额
    NSString *_repaymentTime;//最后还款时间
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableViewHeadView;
//@property (nonatomic, strong) UILabel *companyLbl;
///最后还款
@property (nonatomic, strong) UILabel *lastpayDateLbl;
///累计欠款
@property (nonatomic ,strong) UILabel *totalborrowLbl;
@property(nonatomic,strong)UITextField *searchTF;
@property(nonatomic,strong)NSMutableArray *customerList;
@property(nonatomic,strong)NSMutableArray *customerNameAry;
@property(nonatomic,strong)NSMutableArray *customerIdAry;
@property(nonatomic,copy)NSString *customerId;///选择中的客户id
@property(nonatomic,strong)NSArray<LZCheckReceiptModel*> *lists;
@property(nonatomic,strong)NSString *selecStr;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation CustomerReconciliationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupCustomerList];
}

- (void)setupUI
{
    [self setupTableviewHeadView];
    
    self.navigationItem.titleView = [Utility navTitleView:@"客户对账表"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toScreenClick) image:IMAGE(@"screen1")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //放大镜图标
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 18)];
    UIImageView *searchIM = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search1"]];
    searchIM.frame = CGRectMake(15, 0, 18, 18);
    [searchView addSubview:searchIM];
    
    _searchTF = [[UITextField alloc]init];
    _searchTF.placeholder = @" 请先选择对账单";
    _searchTF.delegate = self;
    _searchTF.leftView = searchView;
    _searchTF.borderStyle = UITextBorderStyleLine;
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.scrollView = self.view;
    _searchTF.positionType = ZJPositionBottomThree;
    [self.view addSubview:_searchTF];
    [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight+10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_offset(35);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.tableViewHeadView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    //隐藏分割线
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(_searchTF.mas_bottom).offset(10);
    }];
    
        [self setupBottomView];
}

- (void)setupTableviewHeadView
{
    //tableview顶部试图
    self.tableViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 30)];
    self.tableViewHeadView.backgroundColor = [UIColor whiteColor];
    
    //公司
//    self.companyLbl = [[UILabel alloc]init];
//    self.companyLbl.text = @"蔡怕啥.灵类似经公司";
//    self.companyLbl.textColor = CD_Text99;
//    self.companyLbl.font = FONT(14);
//    [self.tableViewHeadView addSubview:self.companyLbl];
    
    //导出
    UILabel *outLbl = [[UILabel alloc]init];
    outLbl.text = @"导出";
    outLbl.textAlignment = NSTextAlignmentRight;
    outLbl.textColor = [UIColor colorWithHexString:@"#3d9bfa"];
    [self.tableViewHeadView addSubview:outLbl];
    
    //导出按钮
    UIButton *outBtn = [[UIButton alloc]init];
    [outBtn setImage:IMAGE(@"export") forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(outBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [outBtn setBackgroundColor:[UIColor clearColor]];
    [self.tableViewHeadView addSubview:outBtn];
    
    //线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [self.tableViewHeadView addSubview:lineView];
    
//    self.companyLbl.sd_layout
//    .leftSpaceToView(self.tableViewHeadView, 15)
//    .centerYEqualToView(self.tableViewHeadView)
//    .widthIs(APPWidth/3)
//    .heightIs(15);
    
    outBtn.sd_layout
    .rightSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView)
    .widthIs(16)
    .heightIs(16);
    
    outLbl.sd_layout
    .rightSpaceToView(outBtn, 10)
    .centerYEqualToView(self.tableViewHeadView)
    .heightIs(15)
    .widthIs(50);
    
    lineView.sd_layout
    .bottomSpaceToView(self.tableViewHeadView, -1)
    .heightIs(1)
    .widthIs(APPWidth)
    .leftSpaceToView(self.tableViewHeadView, 0);
    
}


- (void)setupBottomView
{
    //最后还款
    self.lastpayDateLbl = [[UILabel alloc]init];
    self.lastpayDateLbl.backgroundColor = [UIColor whiteColor];
    self.lastpayDateLbl.textAlignment = NSTextAlignmentCenter;
    self.lastpayDateLbl.font = FONT(12);
    self.lastpayDateLbl.textColor = CD_Text33;
    self.lastpayDateLbl.text = @"最后还款：2018-3-30";
    [self.view addSubview:self.lastpayDateLbl];
    self.lastpayDateLbl.sd_layout
    .leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(APPWidth/2)
    .heightIs(44);
    
    //累计欠款
    self.totalborrowLbl = [[UILabel alloc]init];
    self.totalborrowLbl.backgroundColor = [UIColor whiteColor];
    self.totalborrowLbl.textAlignment = NSTextAlignmentCenter;
    self.totalborrowLbl.font = FONT(12);
    self.totalborrowLbl.textColor = CD_Text33;
    self.totalborrowLbl.text = @"累计欠款：454541.00";
    [self.view addSubview:self.totalborrowLbl];
    self.totalborrowLbl.sd_layout
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(APPWidth/2)
    .heightIs(44);
    
}

#pragma mark ----- 网络请求 -----
//接口名称 功能用到客户列表
- (void)setupCustomerList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"customer/customer_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _customerList = baseModel.data;
        _customerNameAry = [NSMutableArray array];
        _customerIdAry = [NSMutableArray array];
        for (int i = 0 ; i <_customerList.count; i++) {
            [_customerNameAry addObject:_customerList[i][@"name"]];
            [_customerIdAry addObject:_customerList[i][@"id"]];
        }
        //        名称cell设置数据源 获取客户id
        WEAKSELF
        [_searchTF popOverSource:_customerNameAry index:^(NSInteger index) {
            _customerId = _customerList[index][@"id"];
            [weakSelf setupListData];
        }];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 客户对账列表
- (void)setupListData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"customerId":_customerId,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"startDate":_startStr == nil ? @"" : _startStr,
                             @"endDate":_endStr == nil ? @"" : _endStr
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/coustomer_bill_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZCheckReceiptModel LLMJParse:baseModel.data];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 对账单客户信息
- (void)setupCoustomerInfo{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"customerId":_customerId == nil ? @"" : _customerId
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/coustomer_bill_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZCheckReceiptModel LLMJParse:baseModel.data];
        
        [self.tableView reloadData];
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
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"CustomerReconciliationTableViewCell";
    
    CustomerReconciliationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[CustomerReconciliationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZCheckReceiptModel *model = _lists[indexPath.row];

    if ([model.type integerValue] == 0) {
        //销售单
    }
    if ([model.type integerValue] == 1) {
        //退货单
    }
    if ([model.type integerValue] == 2) {
        //客户收款单
        LZCollectionCheckVC *vc = [[LZCollectionCheckVC alloc]init];
        vc.orderNo = model.orderNo;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ------- 点击事件 ---------
- (void)outBtnOnClick
{
    NSLog(@"outBtnOnClick");
}

- (void)toScreenClick
{
    _bottomView.hidden = NO;
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
- (void)headerTapClick{
    _bottomView.hidden = NO;
}
//点击日历确定
- (void)didaffirmBtnInCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = [BXSTools stringFromTData:StartStr];
    _endStr = [BXSTools stringFromTData:EndStr];
    _bottomView.hidden = YES;
    [self setupListData];
//    if (![_startStr isEqualToString:@"0"]) {
//        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
//    }else{
//        _dateLbl.text = _endStr;
//    }
}

//点击周历确定
- (void)didaffirmBtnInWeekCalendarWithSelectArray:(NSMutableArray *)weekArray{
    NSString *str1 = [NSString stringWithFormat:@"%@",[weekArray firstObject]];
    NSString *str2 = [NSString stringWithFormat:@"%@",[weekArray lastObject]];
    
    _startStr = [BXSTools stringFromTData:str1];
    _endStr = [BXSTools stringFromTData:str2];
    [self setupListData];
    _bottomView.hidden = YES;
//    if (![_startStr isEqualToString:@"0"]) {
//        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
//        _dateLbl.textColor = CD_Text33;
//    }else{
//        _dateLbl.text = _endStr;
//        _dateLbl.textColor = CD_Text33;
//    }
}

//点击月历确定
- (void)didaffirmBtnInMonthCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupListData];
    _bottomView.hidden = YES;
//    if (![_startStr isEqualToString:@"0"]) {
//        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
//        _dateLbl.textColor = CD_Text33;
//    }else{
//        _dateLbl.text = _endStr;
//        _dateLbl.textColor = CD_Text33;
//    }
}

//点击季度确定
- (void)didaffirmBtnInQuarterCalendarWithDateStartStr:(NSString *)StartStr andEndStr:(NSString *)EndStr{
    _startStr = StartStr;
    _endStr = EndStr;
    [self setupListData];
    _bottomView.hidden = YES;
//    if (![_startStr isEqualToString:@"0"]) {
//        _dateLbl.text = [NSString stringWithFormat:@"    %@ 至 %@",_startStr,_endStr];
//        _dateLbl.textColor = CD_Text33;
//    }else{
//        _dateLbl.text = _endStr;
//        _dateLbl.textColor = CD_Text33;
//    }
}

//点击日历取消
- (void)didCancelBtnInCalendar{
    _bottomView.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
