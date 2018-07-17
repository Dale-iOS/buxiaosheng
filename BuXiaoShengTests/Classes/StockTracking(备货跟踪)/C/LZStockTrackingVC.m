//
//  LZStockTrackingVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  备货跟踪页面

#import "LZStockTrackingVC.h"
#import "StockTrackingCell.h"
#import "LZBugAndProcessBssModel.h"
#import "LZDidStockTrackingVC.h"

@interface LZStockTrackingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSArray<LZBugAndProcessBssModel*> *lists;

@end

@implementation LZStockTrackingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"备货跟踪"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationRightClick) image:IMAGE(@"new_lists")];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
}

#pragma mark ---- 网络请求 ----
//接口名称 备货跟踪
- (void)setupList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"status":@"0"
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/trackhouse_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZBugAndProcessBssModel LLMJParse:baseModel.data];
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
//    return 150;
    
//     >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id listModel = _lists[indexPath.row];

    return [_tableView cellHeightForIndexPath:indexPath model:listModel keyPath:@"model" cellClass:[StockTrackingCell class] contentViewWidth:APPWidth];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"StockTrackingCell";
    StockTrackingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[StockTrackingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}


#pragma mark ---- 点击事件 ----
- (void)navigationRightClick{
    LZDidStockTrackingVC *vc = [[LZDidStockTrackingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
