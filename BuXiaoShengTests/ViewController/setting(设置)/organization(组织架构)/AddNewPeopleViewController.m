//
//  AddNewPeopleViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加人员页面

#import "AddNewPeopleViewController.h"
#import "LLAddNewPeopleModel.h"
#import "LLAddNewPeopleCell.h"
#import "LLAddNewsPeopleSectionView.h"
#import "LLAddNewsPepleContainerCell.h"
@interface AddNewPeopleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSDictionary * details;

@property (nonatomic,strong) NSArray * member_exis_roles;
@end

@implementation AddNewPeopleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupUI];
      [self setupData];
    [self setupDepartmentData];
    [self setupSectionData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加人员"];
    
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
    NSDictionary * param = @{@"id":[BXSUser currentUser].userId};
    [BXSHttp requestGETWithAppURL:@"member/detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        self.details = baseModel.data;
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
                               @"memberId":[BXSUser currentUser].userId
                               };
    [BXSHttp requestGETWithAppURL:@"member/member_exis_role.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.details.count;
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
        return 25;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LLAddNewPeopleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLAddNewPeopleCell"];
        cell.indexPath = indexPath;
        cell.model = [LLAddNewPeopleModel LLMJParse:self.details];
        return cell;
    }
    LLAddNewsPepleContainerCell * cell =[ tableView dequeueReusableCellWithIdentifier:@"LLAddNewsPepleContainerCell"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 49;
    }

    int lineCount =
    10%4 ? 10/4 + 1: 10/4;
    return lineCount*LLScale_WIDTH(130)+lineCount*15 + 15;
}


-(void)selectornavRightBtnClick {
    
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LLAddNewPeopleCell class] forCellReuseIdentifier:@"LLAddNewPeopleCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[LLAddNewsPeopleSectionView class] forHeaderFooterViewReuseIdentifier:@"LLAddNewsPeopleSectionView"];
        [_tableView registerClass:[LLAddNewsPepleContainerCell class] forCellReuseIdentifier:@"LLAddNewsPepleContainerCell"];
    }
    return _tableView;
}


@end
