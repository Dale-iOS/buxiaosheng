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

@interface NoAuditInStorageViewController ()<UITableViewDelegate,UITableViewDataSource,LZProcurementCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZProcurementModel *> *listDatas;
@end

@implementation NoAuditInStorageViewController

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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -LLNavViewHeight-88) style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark ------- 网络请求 --------
//接口名称 采购审批列表
- (void)setupListData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"status":@"0"
                            };
    [BXSHttp requestGETWithAppURL:@"approval/buy_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _listDatas = [LZProcurementModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listDatas.count;
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
    }
    cell.model = _listDatas[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)didClickgoAuditBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    LZProcurementModel *model = _listDatas[indexP.row];
    //id
//    model.id;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
