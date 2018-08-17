//
//  ClientNeedsViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户需求-未出库页面

#import "ClientNeedsViewController.h"
#import "AuditTableViewCell.h"
#import "OutboundViewController.h"
#import "LZClientDemandModel.h"
#import "LZSearchClientNeedsVC.h"
#import "ProcessViewController.h"//贤哥写的指派

static NSInteger const pageSize = 15;
@interface ClientNeedsViewController ()<UITableViewDelegate,UITableViewDataSource,AuditTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LZClientDemandModel *> *lists;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation ClientNeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"客户需求-未出库"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(ToSearch) image:IMAGE(@"new_lists")];
    
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
    [self.view addSubview:self.tableView];
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

#pragma mark ------- 网络请求 --------
//未出库-销售需求
- (void)setupList
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize)
                            };
    [BXSHttp requestGETWithAppURL:@"storehouse/out_storage_list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZClientDemandModel *model = [LZClientDemandModel mj_objectWithKeyValues:dic];
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
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AuditTableViewCell";
    AuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AuditTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.delegate = self;
        cell.stateLabel.hidden = YES;
        [cell.yesBtn setTitle:@"出库" forState:UIControlStateNormal];
        [cell.noBtn setTitle:@"指派" forState:UIControlStateNormal];
    }
    cell.model = _lists[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark -------- AuditTableViewCellDelegate -------
//指派按钮事件
- (void)didClickNoBtnInCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LZClientDemandModel *model = _lists[indexPath.row];
    
    
    ProcessViewController *vc = [[ProcessViewController alloc]init];
    vc.orderId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

//出库按钮事件
- (void)didClickYesBtnInCell:(UITableViewCell *)cell
{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    
    OutboundViewController *vc = [[OutboundViewController alloc]init];
    LZClientDemandModel *model = _lists[indexP.row];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ------ 点击事件 -------
- (void)ToSearch
{
    [self.navigationController pushViewController:[[LZSearchClientNeedsVC alloc]init] animated:YES];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZClientDemandModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
