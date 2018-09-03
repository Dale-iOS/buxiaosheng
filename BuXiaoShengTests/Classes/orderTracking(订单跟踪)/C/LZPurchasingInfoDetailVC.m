//
//  LZPurchasingInfoDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  订单详情（来自采购信息列表）

#import "LZPurchasingInfoDetailVC.h"
#import "LZPurchasingInfoDetailModel.h"

@interface LZPurchasingInfoDetailVC ()
@property (nonatomic, strong) LZPurchasingInfoDetailModel *detailModel;
@property (nonatomic, strong) LZPurchasingInfoDetaiLogisticslModel *logisticsModel;
@end

@implementation LZPurchasingInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.navigationItem.titleView = [Utility navTitleView:@"订单详情"];
    
    [self getProductDetail];
    [self getProductLogistics];
}

#pragma mark ---- 网络请求 ----
//接口名称 采购信息产品详情
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#305
- (void)getProductDetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.buyId
                             };
    [BXSHttp requestGETWithAppURL:@"sale/procurement_product_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _detailModel = [LZPurchasingInfoDetailModel LLMJParse:baseModel.data];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 采购信息物流详情
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#306
- (void)getProductLogistics{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.buyId
                             };
    [BXSHttp requestGETWithAppURL:@"sale/procurement_logistics_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _logisticsModel = [LZPurchasingInfoDetaiLogisticslModel LLMJParse:baseModel.data];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
