//
//  AlterBranchViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改分店页面

#import "AlterBranchViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"

@interface AlterBranchViewController ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///分店名称
@property (nonatomic, strong) TextInputCell *titleCell;
///类型
@property (nonatomic, strong) TextInputCell *typeCell;
///是否结算分点
@property (nonatomic, strong) TextInputCell *settlementCell;
///是否接受任务
@property (nonatomic, strong) TextInputCell *taskCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;


@end

@implementation AlterBranchViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.titleView = [Utility navTitleView:@"添加分店"];
    self.navigationItem.titleView = self.isFormBranchAdd ?[Utility navTitleView:@"添加分店"] : [Utility navTitleView:@"修改分店"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setupSectionOne
{
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.titleLabel.text = @"分店名称";
    self.titleCell.contentTF.placeholder = @"请输入分店名称";
    
    self.typeCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.typeCell.rightArrowImageVIew.hidden = NO;
    self.typeCell.titleLabel.text = @"类型";
    self.typeCell.contentTF.placeholder = @"请选择类型";
    
    self.settlementCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.settlementCell.rightArrowImageVIew.hidden = NO;
    self.settlementCell.titleLabel.text = @"是否结算分店";
    self.settlementCell.contentTF.placeholder = @"请选择类型";
    
    self.taskCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.taskCell.rightArrowImageVIew.hidden = NO;
    self.taskCell.titleLabel.text = @"是否接受任务";
    self.taskCell.contentTF.placeholder = @"请选择类型";
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.placeholder = @"请选择类型";
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.typeCell,self.settlementCell,self.taskCell,self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)selectornavRightBtnClick
{
    NSLog(@"点击了保存按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
