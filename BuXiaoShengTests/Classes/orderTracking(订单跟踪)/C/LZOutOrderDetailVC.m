//
//  LZOutOrderDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutOrderDetailVC.h"
#import "LZOutOrderCustomerModel.h"
#import "LZOutOrderProductModel.h"

@interface LZOutOrderDetailVC ()
@property (nonatomic, strong) LZOutOrderCustomerModel *customerModel;
@property (nonatomic, strong) LZOutOrderProductModel *productModel;
@end

@implementation LZOutOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:self.title];
    
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
        _productModel = [LZOutOrderProductModel LLMJParse:baseModel.data];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
