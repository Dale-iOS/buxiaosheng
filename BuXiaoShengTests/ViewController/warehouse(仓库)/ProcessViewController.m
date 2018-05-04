//
//  ProcessViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购加工页面

#import "ProcessViewController.h"
#import "LLProcessChildVc.h"

@interface ProcessViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,weak) UISegmentedControl * segmented;
@property (nonatomic,strong) UIScrollView * containerView;
@end

@implementation ProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"采购加工"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)setupUI {
    UIView * segmentedView = [self segmentedView];
    [segmentedView layoutIfNeeded];
    
}

-(void)segmentedClick {
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
}

-(UIView *)segmentedView {
    
    UIView *segmentedView = [UIView new];
    [self.view addSubview:segmentedView];
    [segmentedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.mas_equalTo(45);
    }];
    segmentedView.backgroundColor = [UIColor whiteColor];
   UISegmentedControl * segmented = [[UISegmentedControl alloc] initWithItems:@[@"采购",@"加工"]];
    self.segmented = segmented;
    [segmentedView addSubview:segmented];
    segmented.selectedSegmentIndex = 0;
    [segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(segmentedView);
        make.width.mas_equalTo(100);
    }];
    [segmented addTarget:self action:@selector(segmentedClick) forControlEvents:UIControlEventTouchUpInside];
    
    return segmentedView;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
-(UIScrollView *)containerView {
    if (!_containerView) {
        _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, LLNavViewHeight + 45, SCREEN_WIDTH, SCREEN_HEIGHT - LLNavViewHeight - 45)];
        _containerView.delegate = self;
        _containerView.pagingEnabled = true;
        [self.view addSubview:_containerView];
    }
    return _containerView;
}


@end
