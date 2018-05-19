//
//  CashBankViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  现金银行页面

#import "CashBankViewController.h"
#import "CashBankTableViewCell.h"
#import "AlterBankViewController.h"
#import "LLCashBankModel.h"
@interface CashBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,strong) NSArray <LLCashBankModel *> * banks;

@end

@implementation CashBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"现金银行"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CashBankTableViewCell class] forCellReuseIdentifier:@"CashBankTableViewCell"];
    //隐藏分割线
    self.tableView.separatorStyle = NO;

    [self.view addSubview:self.tableView];
}
-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/list.do" param:param success:^(id response) {
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

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.banks.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CashBankTableViewCell";
    CashBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.model = self.banks[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlterBankViewController *vc = [[AlterBankViewController alloc]init];
    vc.isFormBankAdd = false;
    vc.id = self.banks[indexPath.row].id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navigationAddClick
{
    NSLog(@"点击了添加");
    
    AlterBankViewController *vc = [[AlterBankViewController alloc]init];
    vc.isFormBankAdd = true;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
