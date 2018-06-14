//
//  LZPaymentOrderListVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPaymentOrderListVC.h"
#import "LZSearchBar.h"
#import "LZPaymentOrderListModel.h"
#import "LZPaymentOrderListCell.h"
#import "BRPickerView.h"
#import "LZPaymentOrderListDetailVC.h"

@interface LZPaymentOrderListVC ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property(nonatomic,strong)NSArray<LZPaymentOrderListModel*> *lists;
//顶部试图
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *dateText;
@property(nonatomic,strong)UIView *rigthHeadView;
@property(nonatomic,strong)UILabel *dateLbl;
@property(nonatomic,strong)NSString *selecStr;
@end

@implementation LZPaymentOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupListData];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"付款单列表"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"screen1")];
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    //设置顶部时间筛选
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(39);
    }];
    
    _dateText = [[UILabel alloc]init];
    _dateText.textColor = CD_Text33;
    _dateText.font = FONT(14);
    _dateText.text = @"时间";
    [_headView addSubview:_dateText];
    [_dateText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView).offset(15);
        make.centerY.equalTo(_headView);
        make.width.mas_offset(100);
    }];
    _rigthHeadView = [[UIView alloc]init];
    _rigthHeadView.backgroundColor = [UIColor whiteColor];
    _rigthHeadView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTapClick)];
    [_rigthHeadView addGestureRecognizer:headerTap];
    [_headView addSubview:_rigthHeadView];
    [_rigthHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_headView);
        make.top.and.bottom.equalTo(_headView);
        make.width.mas_offset(140);
    }];
    UIImageView *dateImageView = [[UIImageView alloc]init];
    dateImageView.image = IMAGE(@"bankdate");
    [_rigthHeadView addSubview:dateImageView];
    [dateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(16);
        make.height.mas_offset(15);
        make.right.equalTo(_rigthHeadView).offset(-15);
        make.centerY.equalTo(_rigthHeadView);
    }];
    _dateLbl = [[UILabel alloc]init];
    _dateLbl.textColor = CD_Text66;
    _dateLbl.font = FONT(14);
    _dateLbl.text = @"2018-04-12";
    _dateLbl.textAlignment = NSTextAlignmentRight;
    [_rigthHeadView addSubview:_dateLbl];
    [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_offset(15);
        make.right.equalTo(dateImageView.mas_left).offset(-10);
        make.centerY.equalTo(dateImageView);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom).offset(0.5);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark ----- 网络请求 -----
- (void)setupListData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"factoryType":@"",
                             };
    [BXSHttp requestGETWithAppURL:@"finance/payment_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _lists = [LZPaymentOrderListModel LLMJParse:baseModel.data];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZPaymentOrderListCellid";
    LZPaymentOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZPaymentOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZPaymentOrderListModel *model = _lists[indexPath.row];
    LZPaymentOrderListDetailVC *vc = [[LZPaymentOrderListDetailVC alloc]init];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- 点击事件 -----
- (void)navigationSetupClick{
    [BRStringPickerView showStringPickerWithTitle:@"请筛选供货商" dataSource:@[@"全部", @"供货商", @"生厂商",@"加工商"] defaultSelValue:nil resultBlock:^(id selectValue) {
//        textField.text = self.infoModel.genderStr = selectValue;
        if ([selectValue isEqualToString:@"全部"]) {
            _selecStr = @"";
        }else if ([selectValue isEqualToString:@"供货商"]){
            _selecStr = @"0";
        }else if ([selectValue isEqualToString:@"生厂商"]){
            _selecStr = @"1";
        }else if ([selectValue isEqualToString:@"加工商"]){
            _selecStr = @"2";
        }
        
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"pageNo":@"1",
                                 @"pageSize":@"15",
                                 @"factoryType":_selecStr,
                                 };
        [BXSHttp requestGETWithAppURL:@"finance/payment_list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            _lists = [LZPaymentOrderListModel LLMJParse:baseModel.data];
            [_tableView reloadData];
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
    }];
}

- (void)headerTapClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
