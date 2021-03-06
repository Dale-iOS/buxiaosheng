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
    
    self.navigationItem.titleView = self.isFromAdd ? [Utility navTitleView:@"添加部门"] : [Utility navTitleView:@"修改部门"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(selectornavRightBtnClick) title:@"确认"];
    
    //新建部门白色底图
    UIView *whiteBgView = [[UIView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight +10, APPWidth, 49)];
    whiteBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBgView];
    
    UILabel *newDepartmentLbl = [[UILabel alloc]init];
    if (_isFromAdd) {
        newDepartmentLbl.text = @"新建部门";
    }else{
        newDepartmentLbl.text = @"修改部门名称";
    }
    
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
    if (_isFromAdd) {
        //添加
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"name":self.nameTf.text
                                 };
        [BXSHttp requestGETWithAppURL:@"dept/add.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"部门添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:true];
            });
            
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
    }else{
        //修改
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"name":self.nameTf.text,
                                 @"id":self.id
                                 };
        [BXSHttp requestGETWithAppURL:@"dept/update.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"部门修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:true];
            });
            
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
