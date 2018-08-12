//
//  LZCustomerArrearsVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户欠款表页面

#import "LZCustomerArrearsVC.h"
#import "LZChooseArrearClientVC.h"
#import "LZArrearClientModel.h"
#import "LZArrearClientCell.h"

static NSInteger const pageSize = 15;

@interface LZCustomerArrearsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_moneyStr;//侧栏选中的金钱筛选
    NSString *_dateStr;//侧栏选中的日期筛选
}
///分段选择器背景
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<LZArrearClientModel*> *lists;
@property(nonatomic,strong)UIView *headView;
@property (nonatomic,assign) NSInteger  pageIndex;//页数
@end

@implementation LZCustomerArrearsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupListData];
}

- (void)setupUI
{
    self.pageIndex = 1;
    self.navigationItem.titleView = [Utility navTitleView:@"客户欠款表"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toScreenClick) image:IMAGE(@"screen1")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置tableviewHeadView
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 39)];
    _headView.backgroundColor = [UIColor grayColor];
    UILabel *oneLbl = [[UILabel alloc]init];
    oneLbl.font = FONT(14);
    oneLbl.textColor = CD_Text33;
    oneLbl.textAlignment = NSTextAlignmentCenter;
    oneLbl.text = @"客户名称";
    oneLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:oneLbl];
    [oneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    UILabel *twoLbl = [[UILabel alloc]init];
    twoLbl.font = FONT(14);
    twoLbl.textColor = CD_Text33;
    twoLbl.textAlignment = NSTextAlignmentCenter;
    twoLbl.text = @"应收借欠";
    twoLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:twoLbl];
    [twoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneLbl.mas_right);
        make.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.3);
        make.height.mas_offset(39);
    }];
    UILabel *threeLbl = [[UILabel alloc]init];
    threeLbl.font = FONT(14);
    threeLbl.textColor = CD_Text33;
    threeLbl.textAlignment = NSTextAlignmentCenter;
    threeLbl.text = @"最后还款日期";
    threeLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:threeLbl];
    [threeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoLbl.mas_right);
        make.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.3);
        make.height.mas_offset(39);
    }];
    UILabel *fourLbl = [[UILabel alloc]init];
    fourLbl.font = FONT(14);
    fourLbl.textColor = CD_Text33;
    fourLbl.textAlignment = NSTextAlignmentCenter;
    fourLbl.text = @"业务员";
    fourLbl.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_headView addSubview:fourLbl];
    [fourLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(threeLbl .mas_right);
        make.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headView;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
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

#pragma mark ------- 网络请求 --------
//接口名称 客户欠款列表
- (void)setupListData
{
    //    DESC：从高到低 ASC：从低到高）
    NSString *tempMoneyStr = @"DESC";
    NSString *tempDateStr = @"";
    if ([_moneyStr isEqualToString:@"金额从高到低"]) {
        tempMoneyStr = @"DESC";
    }else if ([_moneyStr isEqualToString:@"金额从低到高"]){
        tempMoneyStr = @"ASC";
    }
    
    if ([_dateStr isEqualToString:@"日期从远到近"]) {
        tempDateStr = @"DESC";
    }else if ([_dateStr isEqualToString:@"日期从近到远"]){
        tempDateStr = @"ASC";
    }
//    [model.status integerValue] == 0 ? @"启用" :@"未启用";
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize),
                            @"amountSort":tempMoneyStr,
                            @"dateSort":tempDateStr
                            };
    [BXSHttp requestGETWithAppURL:@"finance_data/coustomer_arrear_list.do" param:param success:^(id response) {

        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [[response objectForKey:@"data"] objectForKey:@"itemList"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZArrearClientModel *model = [LZArrearClientModel mj_objectWithKeyValues:dic];
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZArrearClientCell";
    LZArrearClientCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[LZArrearClientCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)toScreenClick
{
    LZChooseArrearClientVC *vc = [[LZChooseArrearClientVC alloc]init];
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    [vc setSetectBlock:^(NSString *money, NSString *date) {
        _moneyStr = money;
        _dateStr = date;
        [self setupListData];
    }];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZArrearClientModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
