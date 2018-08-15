//
//  SupplierCompanyViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  供货商(厂商)

#import "SupplierCompanyViewController.h"
#import "LLFactoryModel.h"
#import "AddSetCompanyViewController.h"
@interface SupplierCompanyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray <LLFactoryModel *> * factorys;
@end

@implementation SupplierCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (!IOS11Later) {
        [self setupData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)setupData {
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             @"type":@(self.type)
                             };
    [BXSHttp requestGETWithAppURL:@"factory/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.factorys = [LLFactoryModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
        if (!self.factorys.count) {
            [LLHudTools showWithMessage:LLLoadNoMoreMessage];
        }
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.factorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.factorys[indexPath.row].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddSetCompanyViewController *vc = [[AddSetCompanyViewController alloc]init];
    vc.id = self.factorys[indexPath.row].id;

    switch (self.type) {
        case 0:
            vc.navigationItem.titleView = [Utility navTitleView:@"修改供货商"];
            break;
        case 1:
            vc.navigationItem.titleView = [Utility navTitleView:@"修改生产商"];
            break;
        case 2:
            vc.navigationItem.titleView = [Utility navTitleView:@"修改加工商"];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

@end
