//
//  AssignDeliveryViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  指派送货页面

#import "AssignDeliveryViewController.h"
//#import "AddAuditManagerViewController.h"
#import "LZAssignDeliveryModel.h"
#import "AssignDeliveryCell.h"
#import "LZHomeModel.h"
#import "LZChoosseWorkerVC.h"
#import "LZAssignDeliveryListVC.h"

@interface AssignDeliveryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIImageView *allIM;
@property(nonatomic,strong)UILabel *chooseLbl;
@property(nonatomic,strong)NSArray<LZAssignDeliveryModel*> *lists;
@property(nonatomic,strong)NSMutableArray *workersAry;
@property(nonatomic,strong)NSMutableArray *workersNameAry;
@property(nonatomic,strong)NSMutableArray *workersIdAry;
@property(nonatomic,strong)NSString *workerId;
@property(nonatomic,strong)UIView *allSelectView;
@property(nonatomic,strong)UIButton *commitBtn;//提交按钮
@end

@implementation AssignDeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"指派送货"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(ToSearch) image:IMAGE(@"search")];
   
    [self setupData];
    [self setupWorkerList];
    [self setupUI];
}

- (void)setupUI
{
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    
    _allIM = [[UIImageView alloc]initWithImage:IMAGE(@"noSelect")];
    [_headView addSubview:_allIM];
    [_allIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(19);
        make.centerY.equalTo(_headView);
        make.left.equalTo(_headView).offset(15);
    }];
    
    UILabel *allLbl = [[UILabel alloc]init];
    allLbl.font = FONT(14);
    allLbl.textColor = CD_Text33;
    allLbl.text = @"选择全部";
    [_headView addSubview:allLbl];
    [allLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_allIM.mas_right).offset(10);
        make.centerY.equalTo(_headView);
        make.height.mas_offset(15);
        make.width.mas_offset(70);
    }];
    
    _allSelectView = [[UIView alloc]init];
    _allSelectView.backgroundColor = [UIColor clearColor];
    _allSelectView.userInteractionEnabled = YES;
    UITapGestureRecognizer *allViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allTapClick)];
    [_allSelectView addGestureRecognizer:allViewTap];
    [_headView addSubview:_allSelectView];
    [_allSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_allIM.mas_left);
        make.top.and.bottom.equalTo(_headView);
        make.right.equalTo(allLbl.mas_right);
    }];
    
    _chooseLbl = [[UILabel alloc]init];
    _chooseLbl.textColor = CD_textCC;
    _chooseLbl.font = FONT(14);
    _chooseLbl.text = @"请选择指派人 >";
    _chooseLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapChooseClick)];
    [_chooseLbl addGestureRecognizer:tap];
    _chooseLbl.textAlignment = NSTextAlignmentRight;
    [_headView addSubview:_chooseLbl];
    [_chooseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headView).offset(-15);
        make.centerY.equalTo(_headView);
        make.height.mas_offset(15);
        make.width.mas_offset(150);
    }];
    
    _commitBtn = [[UIButton alloc]init];
    [_commitBtn setBackgroundColor:LZAppBlueColor];
    [_commitBtn setTitle:@"确 认" forState:UIControlStateNormal];
    _commitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _commitBtn.titleLabel.font = FONT(14);
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_commitBtn.mas_top);
    }];
}

#pragma mark ----- 网络请求 ------
// 接口：已发货-销售需求
- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15"
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/already_storage_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZAssignDeliveryModel LLMJParse:baseModel.data];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)setupWorkerList
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"approver/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _workersNameAry = [NSMutableArray array];
        _workersIdAry = [NSMutableArray array];
        _workersAry = baseModel.data;
        for (int i = 0; i <_workersAry.count; i++) {
            [_workersNameAry addObject:_workersAry[i][@"memberName"]];
            [_workersIdAry addObject:_workersAry[i][@"id"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ---- tableviewDelegate ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"AssignDeliveryCell";
    AssignDeliveryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[AssignDeliveryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LZAssignDeliveryModel *model = _lists[indexPath.row];
    model.isSelect = ! model.isSelect;
    [_tableView reloadData];
}

#pragma mark ------ 点击事件 -------
- (void)ToSearch
{
    [self.navigationController pushViewController:[LZAssignDeliveryListVC new] animated:YES];
}

//全选
- (void)allTapClick{
    
    static BOOL seleted = false;
    seleted = ! seleted;
    
    if (!seleted) {
        _allIM.image = IMAGE(@"noSelect");
    }else{
        _allIM.image = IMAGE(@"yesSelect");
    }
    [self.lists enumerateObjectsUsingBlock:^(LZAssignDeliveryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          obj.isSelect = seleted;
    }];
    
    [self.tableView reloadData];
}

- (void)tapChooseClick
{
    LZChoosseWorkerVC *vc = [[LZChoosseWorkerVC alloc]init];
    vc.navTitle = @"选择指派人";
    [self.navigationController pushViewController:vc animated:YES];
//    WEAKSELF;
    [vc setChooseBlock:^(NSString *workerId, NSString *workerName) {
        _workerId = workerId;
        _chooseLbl.textColor = CD_Text33;
        _chooseLbl.text = [NSString stringWithFormat:@"指派人：%@",workerName];
    }];
}

//提交按钮
//接口名称 设置订单送货人
- (void)commitBtnClick{
    if ([BXSTools stringIsNullOrEmpty:_workerId]) {
        BXS_Alert(@"请选择指派人员");
        return;
    }
    NSMutableArray * seletedArr = [NSMutableArray array];
    [self.lists enumerateObjectsUsingBlock:^(LZAssignDeliveryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelect) {
            [seletedArr addObject:obj.id];
        }
    }];
    if (seletedArr.count <1) {
        BXS_Alert(@"请至少勾选一项");
        return;
    }
    NSString *selectId = [seletedArr componentsJoinedByString:@","];
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"delivererId":_workerId,
                             @"orderIds":selectId
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/set_deliverer.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [LLHudTools showWithMessage:@"指派成功"];
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
