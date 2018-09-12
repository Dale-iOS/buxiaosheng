//
//  LLBankDetailListChildVc.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLBankDetailListChildVc.h"
#import "BankDetailListTableViewCell.h"
#import "LZBankListModel.h"
#import "BankDetailListViewController.h"
#import "DocumentBankDetailViewController.h"
@interface LLBankDetailListChildVc ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic,strong) NSMutableArray <LZBankListListModel *> *lists;
@property(nonatomic ,assign)NSInteger  pageIndex;
@end

@implementation LLBankDetailListChildVc
-(void)setDateType:(NSInteger)dateType {
    _dateType = dateType;
    [self setupList];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 1;
    // Do any additional setup after loading the view.
    [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

//#pragma mark ---- 网络请求 ----
- (void)setupList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(15),
                             @"startDate":self.startDate?:@"",
                             @"endDate":self.endDate?:@"",
                             @"dateType":@(self.dateType),
                             @"bankId":self.bankId ? :@"",
                             @"incomeType":self.incomeId ? :@"",
                             @"type":_type == nil ? @"" : _type
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/bank_detail_list.do" param:param success:^(id response) {
        LLBaseModel * basModel = [LLBaseModel LLMJParse:response];
        if ([basModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:basModel.msg];
            return ;
        }
        LZBankListModel * bankModel = [LZBankListModel LLMJParse:basModel.data];
        NSArray *itemList = [LZBankListListModel LLMJParse:bankModel.itemList];
        if (self.pageIndex == 1) {
            self.lists = [NSMutableArray arrayWithArray:itemList];
        }else {
            [self.lists addObjectsFromArray:itemList];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        BankDetailListViewController * parentVc = (BankDetailListViewController*)self.parentViewController;
        parentVc.totalRevenueMoenyLable.text = bankModel.totalIncome;
        parentVc.totalSpendingMoenyLable.text = bankModel.totalExpenditure;
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"BankDetailListTableViewCell";

    BankDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {

        cell = [[BankDetailListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocumentBankDetailViewController *vc = [[DocumentBankDetailViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        WEAKSELF;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageIndex = 1;
            [weakSelf setupList];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageIndex+=1;
            [weakSelf setupList];
        }];
    }
    return _tableView;
}


@end
