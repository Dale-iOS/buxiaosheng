//
//  ResponsibleViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  我负责的(客户管理)

#import "ResponsibleViewController.h"
#import "ClientManagerTableViewCell.h"

@interface ResponsibleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ResponsibleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"labelName":@"",
                            @"memberId":[BXSUser currentUser].userId,
                            @"pageNo":@"1",
                            @"pageSize":@"20",
                            @"searchName":@"",
                            @"status":@""
                            
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
       
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            
            [LLHudTools showWithMessage:baseModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupUI
{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
