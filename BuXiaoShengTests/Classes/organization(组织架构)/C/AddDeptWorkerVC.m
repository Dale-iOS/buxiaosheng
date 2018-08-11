//
//  AddDeptWorkerVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加人员页面

#import "AddDeptWorkerVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "LZPickerView.h"
#import "LZDeptListModel.h"

@interface AddDeptWorkerVC ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///选择部门
@property (nonatomic, strong) TextInputCell *choosePartCell;
///人员名称
@property (nonatomic, strong) TextInputCell *peopleNameCell;
///账号
@property (nonatomic, strong) TextInputCell *accountCell;
///账号登录密码
@property (nonatomic, strong) TextInputCell *passwordCell;

@property (nonatomic, strong) NSArray <LZDeptListModel *> *lists;

@property (nonatomic, strong) NSArray *nameAry;
@property (nonatomic, strong) NSArray *idAry;
@property (nonatomic, strong) NSArray *companyIdAry;
@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *companyldStr;

@end

@implementation AddDeptWorkerVC
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupPartsList];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加人员"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(makeSureClick) title:@"确认"];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setSectionOne
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //部门
    self.choosePartCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.choosePartCell.contentTF.placeholder = @"请选择部门";
    self.choosePartCell.titleLabel.text = @"部门";
    self.choosePartCell.rightArrowImageVIew.hidden = NO;
    self.choosePartCell.contentTF.enabled = NO;
    //人员名称
    self.peopleNameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.peopleNameCell.contentTF.placeholder = @"请输入人员名字";
    self.peopleNameCell.titleLabel.text = @"人员名称";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.choosePartCell,self.peopleNameCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //账号
    self.accountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.accountCell.contentTF.placeholder = @"请输入账号手机或ID";
    self.accountCell.titleLabel.text = @"账号";
    //密码
    self.passwordCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.passwordCell.contentTF.placeholder = @"请设置登录密码";
    self.passwordCell.titleLabel.text = @"账号登录密码";
    self.passwordCell.contentTF.secureTextEntry = YES;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.accountCell,self.passwordCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

//获取部门列表数据
- (void)setupPartsList
{
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId
                             };
    [BXSHttp requestPOSTWithAppURL:@"dept/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        self.lists = [LZDeptListModel LLMJParse:baseModel.data];
        NSMutableArray *CompanyIdMuArray= [NSMutableArray array];
        NSMutableArray *IdMuArray = [NSMutableArray array];
        NSMutableArray *NameMuArray = [NSMutableArray array];
        for (int i = 0; i < self.lists.count ; i++) {
            LZDeptListModel *model = self.lists[i];
            if (model.companyId.length > 0 && model.id.length > 0 && model.name.length > 0) {
                [CompanyIdMuArray addObject:model.companyId];
                [IdMuArray addObject:model.id];
                [NameMuArray addObject:model.name];
            }
        }
        self.companyIdAry = [CompanyIdMuArray mutableCopy];
        self.idAry = [IdMuArray mutableCopy];
        self.nameAry = [NameMuArray mutableCopy];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.nameAry.count < 1) {
        [LLHudTools showWithMessage:@"暂无部门可选"];
        return;
    }
    WEAKSELF
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.nameAry titleDataArray:nil];

        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
            weakSelf.choosePartCell.contentTF.text = compoentString;
            NSInteger row = [titileString integerValue];
            weakSelf.idStr = weakSelf.idAry[row];
            weakSelf.companyldStr = weakSelf.companyIdAry[row];

        };
        [self.view addSubview:pickerView];

    }
}

- (void)makeSureClick
{
    if ([BXSTools stringIsNullOrEmpty:self.choosePartCell.contentTF.text]) {
        BXS_Alert(@"请先选择部门");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.peopleNameCell.contentTF.text]) {
        BXS_Alert(@"请先输入人员名字");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.accountCell.contentTF.text]) {
        BXS_Alert(@"请先输入账号");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.passwordCell.contentTF.text]) {
        BXS_Alert(@"请先输入密码");
        return;
    }
    
    
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             @"deptId":self.idStr,
                             @"loginName":self.accountCell.contentTF.text,
                             @"password":[BXSHttp makeMD5:self.passwordCell.contentTF.text],
                            @"realName":self.peopleNameCell.contentTF.text
                             };
    [BXSHttp requestPOSTWithAppURL:@"member/add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        [LLHudTools showWithMessage:baseModel.msg];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
