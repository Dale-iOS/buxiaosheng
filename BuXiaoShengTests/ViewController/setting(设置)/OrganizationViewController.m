//
//  OrganizationViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  组织架构页面

#import "OrganizationViewController.h"

@interface OrganizationViewController ()

@end

@implementation OrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"组织架构"];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, APPHeight -49, APPWidth, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //添加部门
    UIView *addDepartmentView = [[UIView alloc]init];
    addDepartmentView.userInteractionEnabled = YES;
    addDepartmentView.frame = CGRectMake(0, 0, APPWidth/2, 49);
    addDepartmentView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *addDepartmentViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addDepartmentViewTapAction)];
    [addDepartmentView addGestureRecognizer:addDepartmentViewTap];
    [bottomView addSubview:addDepartmentView];
    
    UILabel *addDepLbl = [[UILabel alloc]init];
    addDepLbl.text = @"添加部门";
    addDepLbl.textColor = [UIColor colorWithHexString:@"#3d9bfa"];
    addDepLbl.font = FONT(13);
    addDepLbl.textAlignment = NSTextAlignmentCenter;
    [addDepartmentView addSubview:addDepLbl];
    
    UIImageView *addDepIV = [[UIImageView alloc]init];
    addDepIV.backgroundColor = [UIColor clearColor];
    addDepIV.image = IMAGE(@"addDepartment");
    [addDepartmentView addSubview:addDepIV];
    
    addDepLbl.sd_layout
    .centerXEqualToView(addDepartmentView)
    .centerYEqualToView(addDepartmentView)
    .widthIs(55)
    .heightIs(14);
    
    addDepIV.sd_layout
    .widthIs(17)
    .heightIs(17)
    .centerYEqualToView(addDepartmentView)
    .leftSpaceToView(addDepLbl, 10);
    
    
    //添加人员
    UIView *addPeopleView = [[UIView alloc]init];
    addPeopleView.userInteractionEnabled = YES;
    addPeopleView.frame = CGRectMake(APPWidth/2, 0, APPWidth/2, 49);
    addPeopleView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *addPeopleViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPeopleViewTapAction)];
    [addPeopleView addGestureRecognizer:addPeopleViewTap];
    [bottomView addSubview:addPeopleView];
    
    UILabel *addPeopleLbl = [[UILabel alloc]init];
    addPeopleLbl.text = @"添加人员";
    addPeopleLbl.textColor = [UIColor colorWithHexString:@"#3d9bfa"];
    addPeopleLbl.font = FONT(13);
    addPeopleLbl.textAlignment = NSTextAlignmentCenter;
    [addPeopleView addSubview:addPeopleLbl];
    
    UIImageView *addDPeopleIV = [[UIImageView alloc]init];
    addDPeopleIV.backgroundColor = [UIColor clearColor];
    addDPeopleIV.image = IMAGE(@"addPeople");
    [addPeopleView addSubview:addDPeopleIV];
    
    addPeopleLbl.sd_layout
    .centerXEqualToView(addPeopleView)
    .centerYEqualToView(addPeopleView)
    .widthIs(55)
    .heightIs(14);
    
    addDPeopleIV.sd_layout
    .widthIs(17)
    .heightIs(17)
    .centerYEqualToView(addPeopleView)
    .leftSpaceToView(addPeopleLbl, 10);
}

//添加部门点击事件
- (void)addDepartmentViewTapAction
{
    NSLog(@"addDepartmentViewTapAction");
}

//添加人员点击事件
- (void)addPeopleViewTapAction
{
    NSLog(@"addPeopleViewTapAction");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
