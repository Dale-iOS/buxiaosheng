//
//  AddNewPeopleViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改人员页面

#import "LLUpdateNewPeopleViewController.h"
#import "LLAddNewPeopleModel.h"
#import "LLAddNewPeopleCell.h"
#import "LLAddNewsPeopleSectionView.h"
#import "LLAddNewsPepleContainerCell.h"
#import "LLAddNewPeoleRoleModel.h"
#import "LLAddPermissionsVc.h"
#import "LZPickerView.h"
#import "LZDeptListModel.h"

@interface LLUpdateNewPeopleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSDictionary * details;

@property (nonatomic,strong) NSArray <LLAddNewPeoleRoleModel*>* roles;
@property (nonatomic,strong) LLAddNewPeopleModel * detailModel;

@property (nonatomic, strong) NSArray <LZDeptListModel *> *lists;

@property (nonatomic, strong) NSArray *nameAry;
@property (nonatomic, strong) NSArray *idAry;
@property (nonatomic, strong) NSArray *companyIdAry;
@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *companyldStr;
@end

@implementation LLUpdateNewPeopleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupUI];
    [self setupPartsList];
    [self setupData];
    [self setupDepartmentData];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupSectionData) name:@"LLAddNewsdelete_role_buttonNotificationCenter" object:nil];
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupSectionData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"修改人员"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo (30);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-LLAddHeight);
    }];
    
}

-(void)setupData{
//用户详情接口
    NSDictionary * param = @{@"id":self.model.id};
    [BXSHttp requestGETWithAppURL:@"member/detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        self.details = baseModel.data;
        self.detailModel = [LLAddNewPeopleModel LLMJParse:baseModel.data];
        self.idStr = self.detailModel.id;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

-(void)setupDepartmentData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"dept/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

-(void)setupSectionData {
      NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                               @"memberId":self.model.id
                               };
    [BXSHttp requestGETWithAppURL:@"member/member_exis_role.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        self.roles = [LLAddNewPeoleRoleModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
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
            LZDeptListModel *model = self.lists[0];
            if (model.companyId.length > 0 && model.id.length > 0 && model.name.length > 0) {
                [CompanyIdMuArray addObject:model.companyId];
                [IdMuArray addObject:model.id];
                [NameMuArray addObject:model.name];
            }
            self.companyIdAry = [CompanyIdMuArray mutableCopy];
            self.idAry = [IdMuArray mutableCopy];
            self.nameAry = [NameMuArray mutableCopy];
        }
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.roles.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UITableViewHeaderFooterView * headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        headerFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return headerFooterView;
    }
    LLAddNewsPeopleSectionView * headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLAddNewsPeopleSectionView"];
    WEAKSELF
    headerFooterView.block = ^(LLAddNewsPeopleSectionView *sectionView) {
        LLAddPermissionsVc * permissonVc = [LLAddPermissionsVc new];
        permissonVc.model = weakSelf.model;
        permissonVc.exis_roles = weakSelf.roles;
        [weakSelf.navigationController pushViewController:permissonVc animated:true];
    };
    headerFooterView.model = self.roles[section -1];
    return headerFooterView;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       static UILabel * temp_promptLable = nil;
        static UIButton * temp_addBtn = nil;
        static UILabel * temp_permissonLable = nil;
        if (indexPath.row ==4) {
            UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
                UILabel * permissonLable = [UILabel new];
                temp_permissonLable = permissonLable;
                [cell.contentView addSubview:permissonLable];
                permissonLable.font = [UIFont systemFontOfSize:15];
                permissonLable.text = @"权限管理";
                [permissonLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.contentView).offset(15);
                    make.top.equalTo(cell.contentView).offset(15);
                }];
              UIButton *  _addPermissions  = [UIButton new];
                temp_addBtn = _addPermissions;
                [_addPermissions addTarget:self action:@selector(addPermissionsClick) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:_addPermissions];
                [_addPermissions setBackgroundImage:[UIImage imageNamed:@"add1"] forState:UIControlStateNormal];
                [_addPermissions mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(cell.contentView.mas_right).offset(-15);
                    make.top.equalTo(cell.contentView).offset(15);
                }];
                
                UILabel * promptLable = [UILabel new];
                temp_promptLable = promptLable;
                [cell.contentView addSubview:promptLable];
                promptLable.text = @"暂无权限,请添加权限";
                [promptLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(cell.contentView);
                }];
            }
             temp_promptLable.hidden = false;
            temp_addBtn.hidden = false;
            if (self.roles.count) {
                temp_promptLable.hidden = true;
                  temp_addBtn.hidden = true;
                [temp_permissonLable mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.contentView).offset(5);
                }];
            }
            return cell;
        }
        LLAddNewPeopleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLAddNewPeopleCell"];
        cell.indexPath = indexPath;
        cell.model = self.detailModel;
        return cell;
        
    }
    LLAddNewsPepleContainerCell * cell =[ tableView dequeueReusableCellWithIdentifier:@"LLAddNewsPepleContainerCell"];
    cell.model = self.roles[indexPath.section-1];
    cell.idModel = _model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            if (self.roles.count) {
                return 30;
            }
            return SCREEN_HEIGHT -LLNavViewHeight - 216;
        }
        return 49;
    }

    int lineCount =
    (self.roles[indexPath.section-1].itemList.count%4) ? ((int)(self.roles[indexPath.section-1].itemList.count/4 + 1)): ((int)(self.roles[indexPath.section-1].itemList.count/4));
    return lineCount*LLScale_WIDTH(130)+lineCount*15 + 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        LLAddNewPeopleCell *cell = (LLAddNewPeopleCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if (self.nameAry.count < 1) {
            [LLHudTools showWithMessage:@"暂无部门可选"];
            return;
        }
        WEAKSELF
        if (indexPath.row == 0 && indexPath.section == 0) {
            
            LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.nameAry titleDataArray:nil];
            
            pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
                cell.rightTextFild.text = compoentString;
                NSInteger row = [titileString integerValue];
                weakSelf.idStr = weakSelf.idAry[row];
                weakSelf.companyldStr = weakSelf.companyIdAry[row];
                
            };
            [self.view addSubview:pickerView];
            
        }

    }
    
}

-(void)addPermissionsClick {
    LLAddPermissionsVc * permissonVc = [LLAddPermissionsVc new];
    permissonVc.model = self.model;
    permissonVc.exis_roles = self.roles;
    [self.navigationController pushViewController:permissonVc animated:true];
}

-(void)selectornavRightBtnClick {
    if ([BXSTools stringIsNullOrEmpty:self.detailModel.realName]) {
        [LLHudTools showWithMessage:@"请输入人员名称"];
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.detailModel.passWord]) {
        [LLHudTools showWithMessage:@"请输入密码"];
        return;
    }
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             @"deptId":self.detailModel.deptId,
                             @"id":self.model.id,
                             @"loginName":self.detailModel.loginName,
                             @"password":[BXSHttp makeMD5:self.detailModel.passWord],
                             @"realName":self.detailModel.realName,
                             };
    [BXSHttp requestPOSTWithAppURL:@"member/update.do" param:param success:^(id response) {
        LLBaseModel * baseModel =[LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [self.navigationController popViewControllerAnimated:true];
    } failure:^(NSError *error) {
        
    }];
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LLAddNewPeopleCell class] forCellReuseIdentifier:@"LLAddNewPeopleCell"];
       // [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[LLAddNewsPeopleSectionView class] forHeaderFooterViewReuseIdentifier:@"LLAddNewsPeopleSectionView"];
        [_tableView registerClass:[LLAddNewsPepleContainerCell class] forCellReuseIdentifier:@"LLAddNewsPepleContainerCell"];
    }
    return _tableView;
}


@end
