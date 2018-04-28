//
//  SetHomeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SetHomeViewController.h"
#import "SettingCell.h"
#import "LZHTableView.h"

@interface SetHomeViewController ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///店铺
@property (nonatomic, strong) SettingCell *storeCell;
///仓库
@property (nonatomic, strong) SettingCell *warehouseCell;
///现金银行
@property (nonatomic, strong) SettingCell *bankCell;
///审批人管理
@property (nonatomic, strong) SettingCell *auditManagerCell;
///科目
@property (nonatomic, strong) SettingCell *subjectCell;
///组织结构
@property (nonatomic, strong) SettingCell *organizationCell;
///产品资料
@property (nonatomic, strong) SettingCell *productCell;
///客户
@property (nonatomic, strong) SettingCell *clientCell;
///厂商
@property (nonatomic, strong) SettingCell *companyCell;
///配方
@property (nonatomic, strong) SettingCell *recipeCell;

@end

@implementation SetHomeViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"设置"];
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    //    [self setupSectionOne];
    [self setupSectionTwo];
    //    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
    
}

- (void)setupSectionTwo
{
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 69)];
    remarkView.backgroundColor = LZHBackgroundColor;
    
    self.storeCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.storeCell.ti
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
