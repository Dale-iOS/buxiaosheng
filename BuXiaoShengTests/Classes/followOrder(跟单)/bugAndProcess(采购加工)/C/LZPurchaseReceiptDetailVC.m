//
//  LZPurchaseReceiptDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseReceiptDetailVC.h"
#import "LZPurchaseReceiptDetailInfoModel.h"
#import "LZPurchaseReceiptDetailCellModel.h"

@interface LZPurchaseReceiptDetailVC ()
@property (nonatomic, strong) LZPurchaseReceiptDetailInfoModel *infoModel;
@property (nonatomic, strong) NSMutableArray <LZPurchaseReceiptDetailCellModel*> *cellInfo;
@end

@implementation LZPurchaseReceiptDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"采购收货详情"];
    [self getProductInfo];
    [self getProductDetail];
}

#pragma mark ---- 网络请求 ----
//接口名称 采购单详情
- (void)getProductInfo{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyOrderId":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/buy_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _infoModel = [LZPurchaseReceiptDetailInfoModel LLMJParse:baseModel.data];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

//口名称 采购单产品详情
- (void)getProductDetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyOrderId":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/buy_product_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _cellInfo = [LZPurchaseReceiptDetailCellModel LLMJParse:baseModel.data];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
