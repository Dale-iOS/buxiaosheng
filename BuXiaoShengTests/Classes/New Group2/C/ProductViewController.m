//
//  ProductViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  产品资料页面

#import "ProductViewController.h"
#import "AddProductViewController.h"
#import "LZAlterProductDataVC.h"
#import "LZSearchBar.h"
//#import "LLFactoryModel.h"
#import "LZChooseLabelVC.h"
#import "LZProductInfoCell.h"
#import "LZProductInfoModel.h"
#import "LZAddProductVC.h"
#import "GKPhotoBrowser.h"

static NSInteger const pageSize = 15;
@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate,LZProductInfoCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong) NSMutableArray <LZProductInfoModel *> *lists;
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation ProductViewController


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
    self.navigationItem.titleView = [Utility navTitleView:@"产品资料"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationScreenClick) image:IMAGE(@"screen3")];
    
    
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
    [self.view addSubview:self.tableView];
    
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf setupList];
    }];
    
    //底部按钮底图
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, APPHeight -49, APPWidth, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //添加部门
    UIView *addView = [[UIView alloc]init];
    addView.userInteractionEnabled = YES;
    addView.frame = CGRectMake(0, 0, APPWidth, 49);
    addView.backgroundColor = LZHBackgroundColor;
    UITapGestureRecognizer *addViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewAction)];
    [addView addGestureRecognizer:addViewTap];
    [bottomView addSubview:addView];
    
    UILabel *addDepLbl = [[UILabel alloc]init];
    addDepLbl.text = @"添加";
    addDepLbl.textColor = [UIColor colorWithHexString:@"#3d9bfa"];
    addDepLbl.font = FONT(14);
    addDepLbl.textAlignment = NSTextAlignmentCenter;
    [addView addSubview:addDepLbl];
    
    UIImageView *addDepIV = [[UIImageView alloc]init];
    addDepIV.backgroundColor = [UIColor clearColor];
    addDepIV.image = IMAGE(@"add2");
    [addView addSubview:addDepIV];
    
    addDepLbl.sd_layout
    .leftSpaceToView(addView, APPWidth/2 -20)
    .centerYEqualToView(addView)
    .widthIs(30)
    .heightIs(14);
    
    addDepIV.sd_layout
    .widthIs(17)
    .heightIs(17)
    .centerYEqualToView(addView)
    .leftSpaceToView(addDepLbl, 5);
}

- (MJRefreshFooter *)reloadMoreData {
    WEAKSELF;
    MJRefreshFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex +=1;
        [weakSelf setupList];
    }];
    return footer;
}

#pragma mark ------- 网络请求 ------
- (void)setupList
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"groupId":@"",
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize)
//                             @"searchName":self.searchBar.text
                             };
    [BXSHttp requestGETWithAppURL:@"product/list.do" param:param success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZProductInfoModel *model = [LZProductInfoModel mj_objectWithKeyValues:dic];
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
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZProductInfoCellid";
    LZProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZProductInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.lists[indexPath.row];
    
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZProductInfoModel *model = self.lists[indexPath.row];
    LZAlterProductDataVC *vc = [[LZAlterProductDataVC alloc]init];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickIconImageViewInCell:(UITableViewCell *)cell{
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
    LZProductInfoModel *model = self.lists[indexP.row];
    if ([model.imgs isEqualToString:@""]) {
        [LLHudTools showWithMessage:@"该产品无图片"];
        return;
    }
    
    NSMutableArray *photos = [NSMutableArray new];
    
    NSMutableArray *photosArrayUrl = [NSMutableArray new];
    [photosArrayUrl addObject:model.imgs];
    
    [photosArrayUrl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:obj];
        
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    
    [browser showFromVC:self];
}

#pragma mark ----- 点击事件 --------
//搜索
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"groupId":@"",
                             @"pageNo":@(self.pageIndex),
                             @"pageSize":@(pageSize),
                             @"searchName":searchText
                             };
    [BXSHttp requestGETWithAppURL:@"product/list.do" param:param success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"] ;
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZProductInfoModel *model = [LZProductInfoModel mj_objectWithKeyValues:dic];
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


- (void)navigationScreenClick
{
    LZChooseLabelVC *vc = [[LZChooseLabelVC alloc]init];
    vc.ToSearchWhat = ToSearchGroup;
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    
    [vc setLabelsDetailBlock:^(NSString *labelString, NSString *labelId) {
        
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"groupId":labelId,
                                 @"pageNo":@(self.pageIndex),
                                 @"pageSize":@(pageSize),
                                 @"searchName":self.searchBar.text
                                 };
        [BXSHttp requestGETWithAppURL:@"product/list.do" param:param success:^(id response) {
            if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
                if (1 == self.pageIndex) {
                    [self.lists removeAllObjects];
                }
                
                NSArray *itemList = [response objectForKey:@"data"] ;
                if (itemList && itemList.count > 0) {
                    for (NSDictionary *dic in itemList) {
                        LZProductInfoModel *model = [LZProductInfoModel mj_objectWithKeyValues:dic];
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
    }];
}

- (void)addViewAction
{
//    AddProductViewController *vc = [[AddProductViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self.navigationController pushViewController:[AddProductViewController new] animated:YES];
    
//    [self.navigationController pushViewController:[LZAddProductVC new] animated:YES];
}

#pragma mark - Getter && Setter
- (NSMutableArray<LZProductInfoModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
