//
//  HomeViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  首页页面

#import "HomeViewController.h"
#import "LLHomePieChartModel.h"
#import "LZHomeModel.h"
#import "SetHomeViewController.h"
#import "LLHomeTableHeaderView.h"
#import "LLHomeChidVC.h"
#import "LLHomeChildContentCollectionCell.h"
#import "LLHomeBaseTableView.h"
#import "SGPageTitleView.h"
#import "LLHomeChidVC.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic ,strong)LLHomePieChartModel * pieChartModel;
@property(nonatomic ,strong)UITableView * tableView;
@property (nonatomic, strong) NSArray <LZHomeModel *> *buttons;
@property(nonatomic ,strong)LLHomeTableHeaderView * headerView;
@property(nonatomic ,strong)UICollectionView * contentCollectView;
@property(nonatomic ,assign)NSInteger selectIndex;
@end

@implementation HomeViewController
//@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"homesetup")];
    [self setupUI];
    [self setupBtns];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.titleView = [Utility navTitleView:[BXSUser currentUser].companyName];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.headerView = [[LLHomeTableHeaderView alloc] init];
    WEAKSELF;
    self.headerView.pageTitleblock = ^(NSInteger selectIndex) {
        weakSelf.selectIndex = selectIndex;
        [weakSelf.contentCollectView setContentOffset:CGPointMake(APPWidth * selectIndex, 0) animated:true];
        [weakSelf setupData];
    };
}

#pragma mark ----- 网络请求 -------
- (void)setupBtns
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"home/button_home.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
       NSArray * buttons = [LZHomeModel LLMJParse:baseModel.data];
        if (buttons.count< 4) {
            self.headerView.frame = CGRectMake(0, 0, APPWidth, 10 + 110 + 10 +260+ 10 + 55 + 10 );
             self.tableView.tableHeaderView = self.headerView;
        }else {
             self.headerView.frame = CGRectMake(0, 0, APPWidth, 10 + 210 + 10 +260+ 10 + 55+ 10);
             self.tableView.tableHeaderView = self.headerView;
        }
         self.headerView.buttons = buttons;
//        [self.collectView reloadData];
//        [self.mainTabelView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

-(void)setupData {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"companyId"] = [BXSUser currentUser].companyId;
    switch (_selectIndex) {
        case 0:
            param[@"dateType"] = @"1";
            break;
        case 1:
            param[@"dateType"] = @"2";
            break;
        case 2:
            param[@"dateType"] = @"3";
            break;
        case 3:
            param[@"dateType"] = @"4";
            break;
        default:
            break;
    }
    [BXSHttp requestGETWithAppURL:@"data_report/index.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.pieChartModel = [LLHomePieChartModel LLMJParse:baseModel.data];
        self.headerView.chartModels =  self.pieChartModel.turnoverList;
        self.headerView.pageTitleView.selectedIndex = self.selectIndex;
        [self.contentCollectView reloadData];
    } failure:^(NSError *error) {
         BXS_Alert(LLLoadErrorMessage)
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        [cell.contentView addSubview:self.contentCollectView];
        [self.contentCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 260 * 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLHomeChildContentCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLHomeChildContentCollectionCell" forIndexPath:indexPath];
    cell.model = self.pieChartModel;
    cell.selectIndex = _selectIndex;
    if (!self.childViewControllers.count) {
        [self addChildViewController:cell.childVc];
    }
    return cell;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView==self.contentCollectView) {
        self.selectIndex = scrollView.contentOffset.x/APPWidth;
        self.headerView.pageTitleView.resetSelectedIndex = scrollView.contentOffset.x/APPWidth;
        return;
    }
    
}

//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    [self scrollViewDidEndDecelerating:scrollView];
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if ([scrollView isEqual:self.contentCollectView]) {
//        return;
//    }
//    CGFloat bottomCellOffset = [self.tableView rectForSection:0].origin.y;
//    if (scrollView.contentOffset.y >= bottomCellOffset) {
//        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
//        if (self.canScroll) {
//            self.canScroll = NO;
//            [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof LLHomeChidVC * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                obj.vcCanScroll = true;
//                if (!obj.vcCanScroll) {
//                    obj.tableView.contentOffset = CGPointZero;
//                }
//            }];
//            //  self.cell.cellCanScroll = YES;
//            
//        }
//    }else{
//        if (!self.canScroll) {//子视图没到顶部
//            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
//        }
//    }
//    //self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
//    
//}



#pragma mark -------- 点击事件 -----------
- (void)navigationSetupClick
{
    SetHomeViewController *vc = [[SetHomeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



/// MARK: ---- 懒加载
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(UICollectionView *)contentCollectView {
    if (!_contentCollectView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, 260 * 3);
        _contentCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _contentCollectView.delegate = self;
        _contentCollectView.dataSource = self;
        _contentCollectView.backgroundColor = [UIColor whiteColor];
        [_contentCollectView registerClass:[LLHomeChildContentCollectionCell class] forCellWithReuseIdentifier:@"LLHomeChildContentCollectionCell"];
        _contentCollectView.pagingEnabled = true;
    }
    return _contentCollectView;
}

@end

