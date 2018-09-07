//
//  NoAuditInStorageViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  入库单（未审批）

#import "NoAuditInStorageViewController.h"
#import "LZProcurementCell.h"
#import "LZProcurementModel.h"
#import "LZPurchaseReceiptDetailVC.h"

static NSInteger const pageSize = 15;
@interface NoAuditInStorageViewController ()<UITableViewDelegate,UITableViewDataSource,LZProcurementCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LZProcurementModel *> *lists;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation NoAuditInStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    if (!IOS11Later) {
        [self setupList];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI
{
    self.pageIndex = 1;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -LLNavViewHeight-88) style:UITableViewStylePlain];
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
//接口名称 采购审批列表
- (void)setupList
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize),
                            @"status":@"0"
                            };
    [BXSHttp requestGETWithAppURL:@"approval/buy_list.do" param:param success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZProcurementModel *model = [LZProcurementModel mj_objectWithKeyValues:dic];
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
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZProcurementCellId";
    LZProcurementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZProcurementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    
    return cell;
}

//进入审批
- (void)didClickgoAuditBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    LZProcurementModel *model = _lists[indexP.row];
    //id
    LZPurchaseReceiptDetailVC *vc = [[LZPurchaseReceiptDetailVC alloc]init];
    vc.bugId = model.buyId;
    vc.Id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZProcurementModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
