//
//  AddNewPeopleViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加人员页面

#import "AddNewPeopleViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"

@interface AddNewPeopleViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///选择部门
@property (nonatomic, strong) TextInputCell * chooseDepartmentCell;
///人员名称
@property (nonatomic, strong) TextInputCell * nameCell;
///账号
@property (nonatomic, strong) TextInputCell * accountCell;
///账号登录密码
@property (nonatomic, strong) TextInputCell * passwordCell;
///名额
@property (nonatomic, strong) UILabel * placesLbl;

@end

@implementation AddNewPeopleViewController
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
    self.navigationItem.titleView = [Utility navTitleView:@"添加人员"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    [self setupSectionTwo];
    
    self.mainTabelView.dataSoure = self.datasource;
    
}

- (void)setupSectionOne
{
    self.chooseDepartmentCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.chooseDepartmentCell.titleLabel.text = @"选择部门";
    self.chooseDepartmentCell.contentTF.placeholder = @"请选择部门";
    self.chooseDepartmentCell.rightArrowImageVIew.hidden = NO;
    
    self.nameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.nameCell.titleLabel.text = @"人员名称";
    self.nameCell.contentTF.placeholder = @"请输入人员名称";
    
    self.accountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.accountCell.titleLabel.text = @"账号";
    self.accountCell.contentTF.placeholder = @"请输入账号";
    
    self.passwordCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.passwordCell.titleLabel.text = @"账号登录密码";
    self.passwordCell.contentTF.placeholder = @"请设置登录密码";
    
    //    还剩n个名额
    UIView * placesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 30)];
    
    self.placesLbl = [[UILabel alloc]init];
    self.placesLbl.text = @"还剩2个名额";
    self.placesLbl.textColor = CD_Text99;
    self.placesLbl.font = FONT(12);
    [placesView addSubview:self.placesLbl];
    self.placesLbl.sd_layout
    .leftSpaceToView(placesView, 15)
    .centerYEqualToView(placesView)
    .widthIs(250)
    .heightIs(13);
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[placesView,self.chooseDepartmentCell,self.nameCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setupSectionTwo
{
    
    self.accountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.accountCell.titleLabel.text = @"账号";
    self.accountCell.contentTF.placeholder = @"请输入账号";
    
    self.passwordCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.passwordCell.titleLabel.text = @"账号登录密码";
    self.passwordCell.contentTF.placeholder = @"请设置登录密码";
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.accountCell,self.passwordCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)selectornavRightBtnClick
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
