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
//@property(nonatomic,strong)UIView *headView;
@property (nonatomic,assign) NSInteger  pageIndex;//页数
//tableView的头部视图
@property(nonatomic ,strong)LLArrearsTableHeaderView * tableHeaderView;
@end

@implementation LZCustomerArrearsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupListData];
     [self.navigationController setNavigationBarHidden:true animated:true];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)setupUI
{
   
   
    self.pageIndex = 1;
//    self.navigationItem.titleView = [Utility navTitleView:@"客户欠款表"];
//    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toScreenClick) image:IMAGE(@"screen1")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置tableviewHeadView
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    //_tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:self.tableHeaderView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tableHeaderView.mas_bottom);
    }];
    
    WEAKSELF;
    _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf setupListData];
    }];
    
    UIView * navView = [self setupNavView];
    [self.view addSubview:navView];
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
            
//            self.tableHeaderView.numberMoenyLable.text = [[response objectForKey:@"data"] objectForKey:@"totalArrear"];
            
            NSArray *itemList = [[response objectForKey:@"data"] objectForKey:@"itemList"];
            
            NSString *totalArrearStr = [NSString stringWithFormat:@"%@",[[response objectForKey:@"data"] objectForKey:@"totalArrear"]];
            NSInteger temp = [totalArrearStr integerValue];
            
            self.tableHeaderView.numberMoenyLable.text = [NSString stringWithFormat:@"%.2ld",(long)temp];
            
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

- (void)rightBtnClick
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
-(void)backBtnClick {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZArrearClientModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}
-(LLArrearsTableHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[LLArrearsTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    }
    return _tableHeaderView;
}
-(UIView*)setupNavView {
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LLNavViewHeight)];
    navView.backgroundColor = [UIColor clearColor];
    UIButton * backBtn = [UIButton new];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backWhite"] forState:UIControlStateNormal];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navView).offset(12);
        make.bottom.equalTo(navView.mas_bottom).offset(-10);
    }];
    UILabel * titleLable = [UILabel new];
    titleLable.textColor = [UIColor whiteColor];
    [navView addSubview:titleLable];
    titleLable.text = @"客户欠款表";
    titleLable.font = [UIFont boldSystemFontOfSize:16];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(navView);
         make.bottom.equalTo(navView.mas_bottom).offset(-10);
    }];
    
    UIButton * rightBtn = [UIButton new];
    [navView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"screenWhite"] forState:UIControlStateNormal];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(navView).offset(-12);
        make.bottom.equalTo(navView.mas_bottom).offset(-10);
    }];
    
    return navView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

@implementation LLArrearsTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrearHeader"]];
        [self addSubview:bgIv];
        [bgIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self).offset(-40);
        }];
        
        self.numberMoenyLable = [UILabel new];
//        self.numberMoenyLable.text = @"510,219.10";
        [bgIv addSubview:self.numberMoenyLable];
        self.numberMoenyLable.font = [UIFont systemFontOfSize:30];
        self.numberMoenyLable.textColor = [UIColor whiteColor];
        self.numberMoenyLable.textAlignment = NSTextAlignmentCenter;
        [self.numberMoenyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgIv);
        }];
        self.messageLale = [UILabel new];
        self.messageLale.text = @"总欠款 (元)";
        [bgIv addSubview:self.messageLale];
        self.messageLale.font = [UIFont systemFontOfSize:17];
        self.messageLale.textColor = [UIColor whiteColor];
        self.messageLale.textAlignment = NSTextAlignmentCenter;
        [self.messageLale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgIv);
            make.top.equalTo(self.numberMoenyLable.mas_bottom).offset(20);
        }];
        
        UIView * titleView = [UIView new];
        titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(bgIv.mas_bottom);
        }];
        NSArray * titles = @[@"客户名称",@"应收借欠",@"最后还款日期",@"业务员"];
        __block CGFloat width = SCREEN_WIDTH/titles.count;
        [titles enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel * lable = [UILabel new];
            [titleView addSubview:lable];
            lable.textColor = [UIColor darkGrayColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:16];
            lable.text = obj;
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleView).offset(idx * width);
                make.top.bottom.equalTo(titleView);
                make.width.mas_equalTo(width);
            }];
        }];
    }
    return self;
}
@end
