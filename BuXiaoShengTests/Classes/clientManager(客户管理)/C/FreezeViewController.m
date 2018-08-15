//
//  FreezeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  冻结的（客户管理）

#import "FreezeViewController.h"
#import "LZClientModel.h"
#import "LZClientManagerModel.h"
#import "ClientManagerTableViewCell.h"
#import "SearchClientViewController.h"
#import "LZChooseLabelVC.h"
#import "AddClienViewController.h"

static NSInteger const pageSize = 15;
@interface FreezeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LZClientManagerModel *> *lists;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@property (nonatomic, strong) UILabel *headLabel;
@end

@implementation FreezeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LZHBackgroundColor;
    
    [self setupUI];
    if (!IOS11Later) {
        [self setupList];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupList];
}

- (void)setupUI
{
    self.pageIndex = 1;
    //    筛选蓝色底图View
    UIView *screenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    screenView.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
    screenView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesOnClick)];
    [screenView addGestureRecognizer:tapGes];
    [self.view addSubview:screenView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"筛选";
    label.font = FONT(13);
    label.textColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = IMAGE(@"screenwihte");
    
    UIView *headBgView = [[UIView alloc]init];
    headBgView.backgroundColor = [UIColor clearColor];
    [screenView addSubview:headBgView];
    [headBgView addSubview:imageView];
    [headBgView addSubview:label];
    
    headBgView.sd_layout
    .centerXEqualToView(screenView)
    .centerYEqualToView(screenView)
    .widthIs(45)
    .heightIs(14);
    
    label.sd_layout
    .leftSpaceToView(headBgView, 0)
    .centerYEqualToView(headBgView)
    .widthIs(27)
    .heightIs(14);
    
    imageView.sd_layout
    .rightSpaceToView(headBgView, 0)
    .centerYEqualToView(headBgView)
    .widthIs(14)
    .heightIs(12);
    
    
    _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, screenView.bottom, APPWidth -15, 25)];
    _headLabel.text = @"共0人";
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
    
    WEAKSELF;
    _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
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

#pragma mark ---- 网络请求 ----
- (void)setupList
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize),
                            @"status":@"1"
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZClientManagerModel *model = [LZClientManagerModel mj_objectWithKeyValues:dic];
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
            _headLabel.text = [NSString stringWithFormat:@"共%zd人",self.lists.count];
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
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ClientManagerTableViewCell";
    ClientManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ClientManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.model = self.lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddClienViewController *vc = [[AddClienViewController alloc]init];
    vc.id = self.lists[indexPath.row].id;
    vc.isFormSelect = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//筛选点击
- (void)tapGesOnClick
{
    LZChooseLabelVC *vc = [[LZChooseLabelVC alloc]init];
    vc.ToSearchWhat = ToSearchLabel;
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    
    WEAKSELF;
    [vc setLabelsArrayBlock:^(NSString *labelString) {
        
        NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                                @"labelName":labelString,
                                @"status":@"1",
                                @"pageNo":@(self.pageIndex),
                                @"pageSize":@(pageSize)
                                
                                };
        [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
            
            if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
                if (1 == weakSelf.pageIndex) {
                    [weakSelf.lists removeAllObjects];
                }
                
                NSArray *itemList = [response objectForKey:@"data"];
                if (itemList && itemList.count > 0) {
                    for (NSDictionary *dic in itemList) {
                        LZClientManagerModel *model = [LZClientManagerModel mj_objectWithKeyValues:dic];
                        [weakSelf.lists addObject:model];
                    }
                    if (weakSelf.lists.count % pageSize) {
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [weakSelf.tableView.mj_footer endRefreshing];
                    }
                } else {
                    //                [LLHudTools showWithMessage:@"暂无更多数据"];
                }
                if (weakSelf.pageIndex == 1) {
                    if (weakSelf.lists.count >= pageSize) {
                        weakSelf.tableView.mj_footer = [weakSelf reloadMoreData];
                    } else {
                        weakSelf.tableView.mj_footer = nil;
                    }
                }
                _headLabel.text = [NSString stringWithFormat:@"共%zd人",weakSelf.lists.count];
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView reloadData];
                
            } else {
                [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView.mj_footer endRefreshing];
            }
            
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    }];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZClientManagerModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

