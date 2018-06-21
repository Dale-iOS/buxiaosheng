//
//  LZPurchasingInfoVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchasingInfoVC.h"
#import "LZBugAndProcessBssModel.h"
#import "StockTrackingCell.h"

@interface LZPurchasingInfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray <LZBugAndProcessBssModel*> *lists;
@end

@implementation LZPurchasingInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupLists];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"采购信息列表"];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
}
#pragma mark ---- 网络请求 ----
- (void)setupLists{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderId":self.orderId,
                             @"pageNo":@"1",
                             @"pageSize":@"15"
                             };
    [BXSHttp requestGETWithAppURL:@"sale/procurement_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZBugAndProcessBssModel LLMJParse:baseModel.data];
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
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"StockTrackingCellId";
    StockTrackingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[StockTrackingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
