//
//  LZNoBackOrderVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  销售单（未审批）

#import "LZNoBackOrderVC.h"
#import "LZNoBackOrderCell.h"
#import "LZNoBackOrderModel.h"

@interface LZNoBackOrderVC ()<UITableViewDelegate,UITableViewDataSource,LZNoBackOrderCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSArray<LZNoBackOrderModel*> *lists;
@end

@implementation LZNoBackOrderVC

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

//接口名称 销售单审批列表
- (void)setupListData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"status":@"0"
                            };
    [BXSHttp requestGETWithAppURL:@"approval/refundy_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZNoBackOrderModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
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
    return 185;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZNoBackOrderCellId";
    LZNoBackOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZNoBackOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)didClickgoAuditBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    LZNoBackOrderModel *model = _lists[indexP.row];
    //退货单id
//    model.id
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
