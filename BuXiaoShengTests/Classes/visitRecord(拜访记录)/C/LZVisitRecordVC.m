//
//  LZVisitRecordVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录列表页面

#import "LZVisitRecordVC.h"
#import "LZSearchBar.h"
#import "LZVisitModel.h"
#import "LZVisitRecordCell.h"

@interface LZVisitRecordVC ()<LZSearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)LZSearchBar *searchBar;
@property(nonatomic,strong)NSArray<LZVisitModel*> *lists;
@property(nonatomic,strong)UITableView *myTabelView;
@end

@implementation LZVisitRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupListData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录列表"];
    
    //初始化搜索框
     self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 44)];
    self.searchBar.placeholder = @"输入品名或批号搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];

    self.myTabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.myTabelView.delegate = self;
    self.myTabelView.dataSource = self;
    self.myTabelView.tableFooterView = [[UIView alloc]init];
    self.myTabelView.backgroundColor = LZHBackgroundColor;
    //隐藏分割线
    self.myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTabelView];
    [self.myTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

//接口名称 拜访记录列表
#pragma mark ----- 网络请求 -----
- (void)setupListData{
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15"
                             };
    [BXSHttp requestGETWithAppURL:@"record/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZVisitModel LLMJParse:baseModel.data];
        [self.myTabelView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
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
    return 122;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"CustomerArrearsTableViewCell";
    
    LZVisitRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[LZVisitRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
