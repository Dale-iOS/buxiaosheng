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
#import "LZDesignateVC.h"

@interface ClientNeedsViewController ()<UITableViewDelegate,UITableViewDataSource,AuditTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LZClientDemandModel *> *listDatas;

@end

@implementation ClientNeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"客户需求-未出库"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(ToSearch) image:IMAGE(@"search")];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
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
//未出库-销售需求
- (void)setupListData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15"
                            };
    [BXSHttp requestGETWithAppURL:@"storehouse/out_storage_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _listDatas = [LZClientDemandModel LLMJParse:baseModel.data];
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
    cell.model = _listDatas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark -------- AuditTableViewCellDelegate -------
//出库按钮事件
- (void)didClickYesBtnInCell:(UITableViewCell *)cell
{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    
    OutboundViewController *vc = [[OutboundViewController alloc]init];
    LZClientDemandModel *model = _listDatas[indexP.row];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

//指派按钮事件
- (void)didClickNoBtnInCell:(UITableViewCell *)cell
{
    LZDesignateVC *vc = [[LZDesignateVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ------ 点击事件 -------
- (void)ToSearch
{

    [self.navigationController pushViewController:[[LZSearchClientNeedsVC alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
