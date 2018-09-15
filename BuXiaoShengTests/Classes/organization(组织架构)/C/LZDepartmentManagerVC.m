//
//  LZDepartmentManagerVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  部门管理页面

#import "LZDepartmentManagerVC.h"
#import "LZDepartmentManagerModel.h"
#import "LZDepartmentManagerCell.h"
#import "AddDepartmentViewController.h"

@interface LZDepartmentManagerVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSArray <LZDepartmentManagerModel*> *lists;
@end

@implementation LZDepartmentManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI{
    self.view.backgroundColor = LZHBackgroundColor;
    self.navigationItem.titleView = [Utility navTitleView:@"部门管理"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!IPHONEX) {
            make.top.equalTo(self.view).offset(10);
        }else{
            make.top.equalTo(self.view).offset(LLNavViewHeight +10);
        }
        
        make.left.and.right.and.bottom.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark ----- 网络请求 ------
// 接口：已发货-销售需求
- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId
                             };
    [BXSHttp requestGETWithAppURL:@"dept/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZDepartmentManagerModel LLMJParse:baseModel.data];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ---- tableviewDelegate ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"LZDepartmentManagerCellId";
    LZDepartmentManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[LZDepartmentManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LZDepartmentManagerModel *model = _lists[indexPath.row];
    AddDepartmentViewController *vc = [[AddDepartmentViewController alloc]init];
    vc.isFromAdd = NO;
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
