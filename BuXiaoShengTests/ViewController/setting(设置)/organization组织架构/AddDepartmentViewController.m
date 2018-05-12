//
//  AddDepartmentViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加部门页面

#import "AddDepartmentViewController.h"

@interface AddDepartmentViewController ()

@end

@implementation AddDepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加部门"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    //新建部门白色底图
    UIView *whiteBgView = [[UIView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight +10, APPWidth, 49)];
    whiteBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBgView];
    
    UILabel *newDepartmentLbl = [[UILabel alloc]init];
    newDepartmentLbl.text = @"新建部门";
    newDepartmentLbl.font = FONT(14);
    newDepartmentLbl.textColor = CD_Text33;
    [whiteBgView addSubview:newDepartmentLbl];
    
    UITextField *nameTf = [[UITextField alloc]init];
    nameTf.placeholder = @"请输入部门名称";
    nameTf.textColor = CD_Text33;
    nameTf.font = FONT(14);
    [whiteBgView addSubview:nameTf];
    
    //自动布局
    newDepartmentLbl.sd_layout
    .leftSpaceToView(whiteBgView, 15)
    .widthIs(100)
    .heightRatioToView(whiteBgView, 1)
    .topEqualToView(whiteBgView);
    
    nameTf.sd_layout
    .topEqualToView(whiteBgView)
    .leftSpaceToView(whiteBgView, 130)
    .heightRatioToView(whiteBgView, 1)
    .widthIs(250);
}

- (void)selectornavRightBtnClick
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
