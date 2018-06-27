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
#import "LZDepartmentManagerVC.h"

@interface OrganizationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray <LLAuditMangerModel *> * manages;
@property(nonatomic,copy)NSString *workersStr;//剩余的人数
@property(nonatomic,strong)UILabel *headLbl;//tableview头部试图
@end

@implementation OrganizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupData];
    [self setupWorkersData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"组织架构"];
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"部门管理" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(navRightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
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

- (void)setTableViewHeadView{
    _headLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    _headLbl.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _headLbl.textColor = CD_Text99;
    _headLbl.font = FONT(12);
    _headLbl.text = [NSString stringWithFormat:@"    %@（还剩%@个名额）",[BXSUser currentUser].companyName,_workersStr];
    
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_headLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"    %@",[BXSUser currentUser].companyName]]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text33 range:oneRange];
    _headLbl.attributedText = temgpStr;
    
    self.tableView.tableHeaderView = _headLbl;
}

#pragma mark --- 网络请求 ---
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

//接口名称 剩余用户数量
- (void)setupWorkersData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"member/surplus_member_number.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _workersStr = baseModel.data;
        [self setTableViewHeadView];
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
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = LZHBackgroundColor;
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
    vc.isFromAdd = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//添加人员点击事件
- (void)addPeopleViewTapAction
{
    
    AddDeptWorkerVC *vc = [[AddDeptWorkerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navRightClick{
    [self.navigationController pushViewController:[LZDepartmentManagerVC new] animated:YES];
}


@end
