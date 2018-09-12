//
//  LZOutOrderDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  仓库出库详情页面

#import "LZOutOrderDetailVC.h"
#import "LZOutOrderCustomerModel.h"
#import "LZOutOrderProductModel.h"
#import "OrderCustomerCell.h"
#import "OrderColorsCell.h"
#import "OrderTotalCell.h"

@interface LZOutOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LZOutOrderCustomerModel *customerModel;
@property (nonatomic, strong) LZOutOrderProductModel *productModel;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LZOutOrderDetailVC

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:self.title];
    [self.view addSubview:self.myTableView];
    _dataArray = [NSMutableArray array];
    self.myTableView.estimatedRowHeight = 200;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self getCustomerData];
}

#pragma mark ---- 网络请求 ----
//接口名称 已出库订单详情（客户信息）
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#322
- (void)getCustomerData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderId
                             };
    [BXSHttp requestGETWithAppURL:@"sale/already_customer_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _customerModel = [LZOutOrderCustomerModel LLMJParse:baseModel.data];
        [self getProductData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 已出库订单详情（产品信息）
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#321
- (void)getProductData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":_customerModel.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"sale/already_product_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _dataArray = [LZOutOrderProductModel LLMJParse:baseModel.data];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 + _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OrderCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCustomerCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCustomerCell" owner:self options:nil] lastObject];
            
        }
        cell.customerModel = self.customerModel;
        return cell;
    }else if (indexPath.row == _dataArray.count + 1) {
        OrderTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTotalCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderTotalCell" owner:self options:nil] lastObject];
            
        }
        cell.dataArray = _dataArray;
        return cell;
    }else
    {
        OrderColorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderColorsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderColorsCell" owner:self options:nil] lastObject];
            
        }
        if (self.dataArray.count > 0) {
            cell.productModel = _dataArray[indexPath.row - 1];
        }
        
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
