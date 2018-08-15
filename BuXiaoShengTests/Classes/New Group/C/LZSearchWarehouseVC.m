//
//  LZSearchWarehouseVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  查找全库存页面

#import "LZSearchWarehouseVC.h"
#import "LZSearchBar.h"
#import "LZInventoryDetailCell.h"
#import "LZInventoryDetailModel.h"
#import "HXTagsView.h"
#import "LLCashBankModel.h"
#import "LZChooseInventoryVC.h"

static NSInteger const pageSize = 15;
@interface LZSearchWarehouseVC ()<LZSearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *_sortId;
    NSString *_unitId;
}
@property(nonatomic,strong)LZSearchBar*searchBar;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSMutableArray<LZInventoryDetailModel *> *lists;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation LZSearchWarehouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI{
    self.pageIndex = 1;
    self.navigationItem.titleView = [Utility navTitleView:@"查找全库存"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenAddClick) image:IMAGE(@"screen3")];
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入品名或批号搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, 39)];
    _headView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.view addSubview:_headView];
    //品名
    UILabel *nameLbl = [[UILabel alloc]init];
    nameLbl.font = FONT(14);
    nameLbl.textColor = CD_Text33;
    nameLbl.textAlignment = NSTextAlignmentCenter;
    nameLbl.text = @"品名";
    [_headView addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //条数
    UILabel *lineLbl = [[UILabel alloc]init];
    lineLbl.font = FONT(14);
    lineLbl.textColor = CD_Text33;
    lineLbl.textAlignment = NSTextAlignmentCenter;
    lineLbl.text = @"条数";
    [_headView addSubview:lineLbl];
    [lineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(nameLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //数量
    UILabel *numLbl = [[UILabel alloc]init];
    numLbl.font = FONT(14);
    numLbl.textColor = CD_Text33;
    numLbl.textAlignment = NSTextAlignmentCenter;
    numLbl.text = @"数量";
    [_headView addSubview:numLbl];
    [numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(lineLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //单位
    UILabel *unitLbl = [[UILabel alloc]init];
    unitLbl.font = FONT(14);
    unitLbl.textColor = CD_Text33;
    unitLbl.textAlignment = NSTextAlignmentCenter;
    unitLbl.text = @"单位";
    [_headView addSubview:unitLbl];
    [unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(numLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //仓库
    UILabel *warehouseLbl = [[UILabel alloc]init];
    warehouseLbl.font = FONT(14);
    warehouseLbl.textColor = CD_Text33;
    warehouseLbl.textAlignment = NSTextAlignmentCenter;
    warehouseLbl.text = @"仓库";
    [_headView addSubview:warehouseLbl];
    [warehouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(unitLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headView.bottom, APPWidth, APPHeight) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LZInventoryDetailCell class] forCellReuseIdentifier:@"LZInventoryDetailCell"];
    [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(_headView.mas_bottom);
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
- (void)setupList
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
//                             @"searchName":self.searchBar.text,
                             @"sort":_sortId == nil ? @"" : _sortId,
                             @"unitId":_unitId == nil ? @"" : _unitId
                             };
    [BXSHttp requestGETWithAppURL:@"house_stock/house_search.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZInventoryDetailModel *model = [LZInventoryDetailModel mj_objectWithKeyValues:dic];
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
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZInventoryDetailCell";
    LZInventoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LZInventoryDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

#pragma mark ---- 抽屉 -----
//点击筛选
- (void)screenAddClick{

    LZChooseInventoryVC *vc = [[LZChooseInventoryVC alloc]init];
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    [vc setSelectIDBlock:^(NSString *sortId, NSString *unitId) {
        if ([sortId isEqualToString:@"从多到少"]) {
            _sortId = @"DESC";
        }else if ([sortId isEqualToString:@"从少到多"]){
            _sortId = @"ASC";
        }
        _unitId = unitId;
    }];
}


- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
                             @"searchName":searchText,
                             @"sort":_sortId == nil ? @"" : _sortId,
                             @"unitId":_unitId == nil ? @"" : _unitId
                             };
    [BXSHttp requestGETWithAppURL:@"house_stock/house_search.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZInventoryDetailModel *model = [LZInventoryDetailModel mj_objectWithKeyValues:dic];
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

#pragma mark - Getter && Setter
- (NSMutableArray<LZInventoryDetailModel
   *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
