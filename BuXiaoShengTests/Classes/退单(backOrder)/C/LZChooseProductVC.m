//
//  LZChooseProductVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseProductVC.h"
#import "LZSearchBar.h"
#import "LLFactoryModel.h"

@interface LZChooseProductVC ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong) NSArray <LLFactoryModel *> *products;
@end

@implementation LZChooseProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"产品资料"];
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入产品名称";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, APPHeight-self.searchBar.height-LLNavViewHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark ------- 网络请求 ------
- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"groupId":@"",
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"searchName":self.searchBar.text
                             };
    [BXSHttp requestGETWithAppURL:@"product/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.products = [LLFactoryModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.products[indexPath.row].name;
    
    return cell;
}

#pragma mark ----- 点击事件 --------
//搜索
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
