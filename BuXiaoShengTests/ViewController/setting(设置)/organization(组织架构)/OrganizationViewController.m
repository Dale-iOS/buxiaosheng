//
//  OrganizationViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  组织架构页面

#import "OrganizationViewController.h"
#import "AddDepartmentViewController.h"
#import "LLUpdateNewPeopleViewController.h"
#import "LLAuditMangerModel.h"
#import "LLAuditMangerSectionView.h"
#import "LLAuditMangerCell.h"
#import "AddDeptWorkerVC.h"

@interface OrganizationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray <LLAuditMangerModel *> * manages;
@end

@implementation OrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
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
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(addDepartmentView.mas_top);
    }];
}

-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"member/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.manages = [LLAuditMangerModel LLMJParse:baseModel.data];
        self.manages.firstObject.sectionClick = true;
        [self.tableView reloadData];
        if (!self.manages.count) {
            [LLHudTools showWithMessage:LLLoadNoMoreMessage];
        }
        
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.manages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.manages[section].sectionClick) {
        return self.manages[section].itemList.count;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LLAuditMangerSectionView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLAuditMangerSectionView"];
    sectionView.section  = section;
    sectionView.model = self.manages[section];
    WEAKSELF
    sectionView.block = ^(LLAuditMangerSectionView *sectionView) {
        [UIView animateWithDuration:0.0 animations:^{
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionView.section] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    };
    return sectionView;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLAuditMangerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLAuditMangerCell"];
    cell.model = self.manages[indexPath.section].itemList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LLUpdateNewPeopleViewController *vc = [[LLUpdateNewPeopleViewController alloc]init];
    vc.model = self.manages[indexPath.section].itemList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.manages[indexPath.section].sectionClick) {
        return 49;
    }
    return 49;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LLAuditMangerCell class] forCellReuseIdentifier:@"LLAuditMangerCell"];
        [_tableView registerClass:[LLAuditMangerSectionView class] forHeaderFooterViewReuseIdentifier:@"LLAuditMangerSectionView"];
    }
    return _tableView;
}

//添加部门点击事件
- (void)addDepartmentViewTapAction
{
    
    AddDepartmentViewController *vc = [[AddDepartmentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//添加人员点击事件
- (void)addPeopleViewTapAction
{
    
    AddDeptWorkerVC *vc = [[AddDeptWorkerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
