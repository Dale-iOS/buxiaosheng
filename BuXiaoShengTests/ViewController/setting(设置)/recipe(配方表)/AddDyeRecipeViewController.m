//
//  AddDyeRecipeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加染色配方

#import "AddDyeRecipeViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"

@interface AddDyeRecipeViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///配方名称
@property (nonatomic, strong) TextInputCell *titleCell;
///单位
@property (nonatomic, strong) TextInputCell *unitCell;

///配方材料
@property (nonatomic, strong) TextInputCell *materialsCell;
///颜色
@property (nonatomic, strong) TextInputCell *colorCell;
///单位(第二部分)
@property (nonatomic, strong) TextInputCell *materialsUnitCell;
///配方单位用料量
@property (nonatomic, strong) TextInputCell *practicalCell;
///计算损耗
@property (nonatomic, strong) TextInputCell *wastageCell;
///计划单位用料量
@property (nonatomic, strong) TextInputCell *projectCell;

@end

@implementation AddDyeRecipeViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    self.navigationItem.titleView = [Utility navTitleView:@"添加染色配方"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    [self setSectionTwo];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setupSectionOne
{
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.titleLabel.text = @"配方名称";
    self.titleCell.contentTF.placeholder = @"请输入配方名称";
    
    self.unitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.unitCell.titleLabel.text = @"单位";
    self.unitCell.contentTF.placeholder = @"请输入公斤数";
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.unitCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    self.materialsCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.materialsCell.rightArrowImageVIew.hidden = NO;
    self.materialsCell.titleLabel.text = @"配方材料";
    self.materialsCell.contentTF.placeholder = @"请选择配方材料";
    
    self.colorCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.colorCell.rightArrowImageVIew.hidden = NO;
    self.colorCell.titleLabel.text = @"颜色";
    self.colorCell.contentTF.placeholder = @"请选择颜色";
    
    self.materialsUnitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.materialsUnitCell.titleLabel.text = @"单位";
    self.materialsUnitCell.contentTF.placeholder = @"请输入单位";
    
    self.practicalCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.practicalCell.titleLabel.text = @"配方单位用料量";
    self.practicalCell.contentTF.placeholder = @"请输入配方单位用料量";
    
    self.wastageCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.wastageCell.titleLabel.text = @"计算损耗";
    self.wastageCell.contentTF.placeholder = @"请输入损耗值";
    
    self.projectCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.projectCell.titleLabel.text = @"计划单位用料量";
    self.projectCell.contentTF.placeholder = @"请输入单位用料量";
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.materialsCell,self.colorCell,self.materialsUnitCell,self.practicalCell,self.wastageCell,self.projectCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)saveBtnClick
{
    NSLog(@"点击了保存按钮");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
