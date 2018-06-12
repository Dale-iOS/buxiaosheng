//
//  NoAuditApplyViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  报销单（未审批）

#import "NoAuditApplyViewController.h"
#import "LZReimbursementCell.h"
#import "LZReimbursementModel.h"

@interface NoAuditApplyViewController ()<UITableViewDelegate,UITableViewDataSource,LZReimbursementCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZReimbursementModel *> *lists;
@end

@implementation NoAuditApplyViewController

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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
    [self.view addSubview:self.tableView];
    
}

#pragma mark ------- 网络请求 --------
//接口名称 销售单审批列表
- (void)setupListData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"status":@"0"
                            };
    [BXSHttp requestGETWithAppURL:@"approval/expend_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZReimbursementModel LLMJParse:baseModel.data];
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
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZReimbursementCellId";
    LZReimbursementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZReimbursementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)didClickYesBtnInCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    LZReimbursementModel *model = _lists[indexPath.row];
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"bankId":@"",
                             @"approvalId":model.id,
                             @"expendId":model.expendId
                             };
    [BXSHttp requestGETWithAppURL:@"approval/expend_agree.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.banks = [LLCashBankModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

- (void)didClickNoBtnInCell:(UITableViewCell *)cell{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
