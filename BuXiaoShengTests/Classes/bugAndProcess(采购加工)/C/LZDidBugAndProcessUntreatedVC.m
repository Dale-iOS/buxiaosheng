//
//  LZDidBugAndProcessUntreatedVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDidBugAndProcessUntreatedVC.h"
#import "LZDidBugAndProcessUntreatedCell.h"
#import "LZBugAndProcessBssModel.h"

@interface LZDidBugAndProcessUntreatedVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray<LZBugAndProcessBssModel*> *lists;
@end

@implementation LZDidBugAndProcessUntreatedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"采购加工-已完成"];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView .backgroundColor = LZHBackgroundColor;
    _tableView .delegate = self;
    _tableView .dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
}

#pragma mark ---- 网络请求 ----
//接口名称 采购加工跟踪-已处理
- (void)setupList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15"
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/yes_handle_list.do" param:param success:^(id response) {
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
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZDidBugAndProcessUntreatedCellId";
    LZDidBugAndProcessUntreatedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[LZDidBugAndProcessUntreatedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
