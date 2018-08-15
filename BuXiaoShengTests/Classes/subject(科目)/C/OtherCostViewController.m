//
//  OtherCostViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  其他费用（科目页面）

#import "OtherCostViewController.h"
#import "ModifySubjectViewController.h"
#import "LZSearchBar.h"
#import "LZSubjectModel.h"

static NSInteger const pageSize = 15;
@interface OtherCostViewController ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong) NSMutableArray <LZSubjectModel *> * lists;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation OtherCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
//    [self setupList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI
{
    self.pageIndex = 1;
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, APPHeight -self.searchBar.bottom -LLNavViewHeight -44) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf setupList];
    }];
}

- (MJRefreshFooter *)reloadMoreData {
    WEAKSELF;
    MJRefreshFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex +=1;
        [weakSelf setupList];
    }];
    return footer;
}

- (void)setupList
{
    NSDictionary *param = @{
                            @"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize),
//                            @"searchName":self.searchBar.text,
                            @"type":@"3"
                            };
    [BXSHttp requestGETWithAppURL:@"costsubject/list.do" param:param success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZSubjectModel *model = [LZSubjectModel mj_objectWithKeyValues:dic];
                    [self.lists addObject:model];
                }
                if (self.lists.count % pageSize) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
            } else {
//                [LLHudTools showWithMessage:@"暂无更多数据"];
            }
            if (self.pageIndex == 1) {
                if (self.lists.count >= pageSize) {
                    self.tableView.mj_footer = [self reloadMoreData];
                } else {
                    self.tableView.mj_footer = nil;
                }
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } else {
            [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lists.count;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.lists[indexPath.row].name;
    
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZSubjectModel *model = [LZSubjectModel LLMJParse:self.lists[indexPath.row]];
    //执行回调block
    if (self.didClickBlock) {
        self.didClickBlock(model);
    }
    
    ModifySubjectViewController *vc = [[ModifySubjectViewController alloc]init];
    vc.id = self.lists[indexPath.row].id;
    if (!_isFromSpend) {
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark ----- searchBarDelegate --------
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSDictionary *param = @{
                            @"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize),
                            @"searchName":searchText,
                            @"type":@"3"
                            };
    [BXSHttp requestGETWithAppURL:@"costsubject/list.do" param:param success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZSubjectModel *model = [LZSubjectModel mj_objectWithKeyValues:dic];
                    [self.lists addObject:model];
                }
                if (self.lists.count % pageSize) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
            } else {
                //                [LLHudTools showWithMessage:@"暂无更多数据"];;
            }
            if (self.pageIndex == 1) {
                if (self.lists.count >= pageSize) {
                    self.tableView.mj_footer = [self reloadMoreData];
                } else {
                    self.tableView.mj_footer = nil;
                }
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } else {
            [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZSubjectModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
