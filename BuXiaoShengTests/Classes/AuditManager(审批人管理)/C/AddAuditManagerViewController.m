//
//  AddAuditManagerViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AddAuditManagerViewController.h"
#import "LLAuditMangerModel.h"
#import "LLAuditMangerSectionView.h"
#import "LLAuditMangerCell.h"
#import "AuditManagerViewController.h"
@interface AddAuditManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray <LLAuditMangerModel *> * manages;
@end

@implementation AddAuditManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加审批人"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-LLAddHeight);
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
   WEAKSELF
    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[AuditManagerViewController class]]) {
            AuditManagerViewController * mangerVc = (AuditManagerViewController*) obj;
            mangerVc.model = weakSelf.manages[indexPath.section].itemList[indexPath.row];
            [weakSelf.navigationController popToViewController:mangerVc animated:true];
            *stop = true;
        }
    }];
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


@end
