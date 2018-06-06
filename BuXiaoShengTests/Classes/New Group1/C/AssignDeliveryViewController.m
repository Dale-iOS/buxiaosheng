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
#import "LZPickerView.h"
#import "LZHomeModel.h"

@interface AssignDeliveryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIImageView *allIM;
@property(nonatomic,strong)UILabel *chooseLbl;
@property(nonatomic,strong)NSArray<LZAssignDeliveryModel*> *lists;
@property(nonatomic,strong)NSMutableArray *workersAry;
@property(nonatomic,strong)NSMutableArray *workersNameAry;
@property(nonatomic,strong)NSMutableArray *workersIdAry;
@property(nonatomic,strong)NSString *workerId;
@end

@implementation AssignDeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"指派送货"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(ToSearch) image:IMAGE(@"search")];
    
    [self setupUI];
    
    //    [self initData];
    //
    //    [self setupChildViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
    [self setupWorkerList];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        
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

#pragma mark ------ 点击事件 -------
- (void)ToSearch
{
    NSLog(@"点击了search");
}

- (void)tapChooseClick
{

    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_workersNameAry titleDataArray:nil];
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//        weakSelf.principalCell.contentTF.text = compoentString;
        NSInteger row = [titileString integerValue];
//        weakSelf.priceipalId = weakSelf.principalIdAry[row];
        NSLog(@"%@++++%@",compoentString,titileString);
    };
    
    [self.view addSubview:pickerView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
