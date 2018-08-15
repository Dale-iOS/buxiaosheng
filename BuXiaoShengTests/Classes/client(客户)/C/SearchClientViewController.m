//
//  SearchClientViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  搜索客户页面

#import "SearchClientViewController.h"
#import "LZSearchBar.h"
#import "LZClientModel.h"
#import "LZClientManagerModel.h"
#import "ClientManagerTableViewCell.h"
#import "SearchClientViewController.h"

static NSInteger const pageSize = 15;
@interface SearchClientViewController ()<LZSearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LZClientManagerModel *> *lists;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation SearchClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"搜索客户"];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupList];
}

- (void)setupUI
{
    self.pageIndex = 1;
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入客户名称";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    
    _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.searchBar.bottom, APPWidth -15, 25)];
    _headLabel.text = @"搜索结果共0条";
    _headLabel.textColor = CD_Text99;
    _headLabel.font = FONT(13);
    _headLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headLabel.bottom, APPWidth, APPHeight -LLNavViewHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    _tableView.tableFooterView = [UIView new];
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

#pragma mark ------ 网络请求 ------
- (void)setupList
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"labelName":@"",
                            @"memberId":@"",
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize)
//                            @"searchName":self.searchBar.text
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZClientManagerModel *model = [LZClientManagerModel mj_objectWithKeyValues:dic];
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
            _headLabel.text = [NSString stringWithFormat:@"搜索结果共%zd条",self.lists.count];
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
    return self.lists.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ClientManagerTableViewCell";
    ClientManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ClientManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = self.lists[indexPath.row];
    return cell;
}


#pragma mark ----- 点击事件 --------
//搜索
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"labelName":@"",
                            @"memberId":@"",
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize),
                            @"searchName":searchText
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZClientManagerModel *model = [LZClientManagerModel mj_objectWithKeyValues:dic];
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
            _headLabel.text = [NSString stringWithFormat:@"搜索结果共%zd条",self.lists.count];
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
- (NSMutableArray<LZClientManagerModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
