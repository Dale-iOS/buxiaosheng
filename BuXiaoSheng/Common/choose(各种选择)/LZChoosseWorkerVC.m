//
//  LZChoosseWorkerVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  选择工作人员

#import "LZChoosseWorkerVC.h"
#import "AddDepartmentViewController.h"
#import "LLUpdateNewPeopleViewController.h"
#import "LLAuditMangerModel.h"
#import "LLAuditMangerSectionView.h"
#import "LLAuditMangerCell.h"
#import "AddDeptWorkerVC.h"

@interface LZChoosseWorkerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray <LLAuditMangerModel *> * manages;

@end

@implementation LZChoosseWorkerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI
{
    self.view.backgroundColor = LZHBackgroundColor;
    self.navigationItem.titleView = [Utility navTitleView:self.navTitle];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(LLNavViewHeight);
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
        make.edges.mas_equalTo(self.view);
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
    //    LLUpdateNewPeopleViewController *vc = [[LLUpdateNewPeopleViewController alloc]init];
    //    vc.model = self.manages[indexPath.section].itemList[indexPath.row];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    LLAuditMangerItemModel *model = self.manages[indexPath.section].itemList[indexPath.row];
    
    if (self.chooseBlock) {
        self.chooseBlock(model.id,model.name);
    }
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
