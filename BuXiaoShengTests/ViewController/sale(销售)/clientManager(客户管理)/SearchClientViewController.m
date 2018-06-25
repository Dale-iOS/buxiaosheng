//
//  SearchClientViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  搜索客户页面

#import "SearchClientViewController.h"
#import "LZSearchBar.h"
#import "LZClientModel.h"
#import "LZClientManagerModel.h"
#import "ClientManagerTableViewCell.h"
#import "SearchClientViewController.h"

@interface SearchClientViewController ()<LZSearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSArray <LZClientManagerModel *> *clients;
@property (nonatomic, strong) UILabel *headLabel;
@end

@implementation SearchClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"搜索客户"];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupData];
}

- (void)setupUI
{
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入客户名称";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    
    _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.searchBar.bottom, APPWidth -15, 25)];
    _headLabel.text = @"搜索结果共0条";
    _headLabel.textColor = CD_Text99;
    _headLabel.font = FONT(13);
    _headLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headLabel.bottom, APPWidth, APPHeight -LLNavViewHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏分割线
    _tableView.separatorStyle = NO;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

#pragma mark ------ 网络请求 ------
- (void)setupData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"labelName":@"",
                            @"memberId":@"",
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"searchName":self.searchBar.text
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
        
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            
            [LLHudTools showWithMessage:baseModel.msg];
        }
        
        self.clients = [LZClientManagerModel LLMJParse:baseModel.data];
        _headLabel.text = [NSString stringWithFormat:@"搜索结果共%zd条",self.clients.count];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clients.count;
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
        cell.model = self.clients[indexPath.row];
    }
    return cell;
}


#pragma mark ----- 点击事件 --------
//搜索
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
