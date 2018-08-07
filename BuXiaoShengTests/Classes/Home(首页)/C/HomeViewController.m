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
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)LLHomePieChartModel * pieChartModel;
@property(nonatomic ,strong)UITableView * tableView;
@property (nonatomic, strong) NSArray <LZHomeModel *> *buttons;
@property(nonatomic ,strong)LLHomeTableHeaderView * headerView;
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
       
        NSMutableArray * array = [NSMutableArray array];
        [array addObjectsFromArray:buttons];
         [array addObjectsFromArray:buttons];
        if (array.count< 3) {
            self.headerView.frame = CGRectMake(0, 0, APPWidth, 10 + 110 + 10 +260+ 10);
             self.tableView.tableHeaderView = self.headerView;
        }else {
             self.headerView.frame = CGRectMake(0, 0, APPWidth, 10 + 210 + 10 +260+ 10);
             self.tableView.tableHeaderView = self.headerView;
        }
         self.headerView.buttons = array;
//        [self.collectView reloadData];
//        [self.mainTabelView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"dateType":@"1"
                             };
    [BXSHttp requestGETWithAppURL:@"data_report/index.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.pieChartModel = [LLHomePieChartModel LLMJParse:baseModel.data];
        self.headerView.chartModels =  self.pieChartModel.turnoverList;
    } failure:^(NSError *error) {
         BXS_Alert(LLLoadErrorMessage)
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
}




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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

@end

