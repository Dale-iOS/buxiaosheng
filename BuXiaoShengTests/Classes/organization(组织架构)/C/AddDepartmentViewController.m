//
//  AddDepartmentViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加部门页面 修改部门页面

#import "AddDepartmentViewController.h"

@interface AddDepartmentViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *nameTf;
@end

@implementation AddDepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    if (_isFromAdd) {
        self.navigationItem.titleView = [Utility navTitleView:@"添加部门"];
    }else{
        self.navigationItem.titleView = [Utility navTitleView:@"修改部门"];
    }
    
    
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
    
    self.nameTf = [[UITextField alloc]init];
    self.nameTf.delegate = self;
    self.nameTf.placeholder = @"请输入部门名称";
    self.nameTf.textColor = CD_Text33;
    self.nameTf.font = FONT(14);
    [whiteBgView addSubview:self.nameTf];
    
    //自动布局
    newDepartmentLbl.sd_layout
    .leftSpaceToView(whiteBgView, 15)
    .widthIs(100)
    .heightRatioToView(whiteBgView, 1)
    .topEqualToView(whiteBgView);
    
    self.nameTf.sd_layout
    .topEqualToView(whiteBgView)
    .leftSpaceToView(whiteBgView, 130)
    .heightRatioToView(whiteBgView, 1)
    .widthIs(250);
}

- (void)selectornavRightBtnClick
{

    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"name":self.nameTf.text
                             };
    [BXSHttp requestGETWithAppURL:@"dept/add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
//        [LLHudTools showWithMessage:@"新增成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LLHudTools showWithMessage:@"部门添加成功"];
            [self.navigationController popViewControllerAnimated:true];
        });
       
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
