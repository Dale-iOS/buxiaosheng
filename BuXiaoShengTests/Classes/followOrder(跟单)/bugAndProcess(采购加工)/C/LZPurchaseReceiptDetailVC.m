//
//  LZPurchaseReceiptDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseReceiptDetailVC.h"

@interface LZPurchaseReceiptDetailVC ()

@end

@implementation LZPurchaseReceiptDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark ---- 网络请求 ----
- (void)getProductInfo{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/order_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

//- (void)getProductDetail{
//    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
//                             @"orderDetailId"
//                             };
//    [BXSHttp requestGETWithAppURL:@"bank/list.do" param:param success:^(id response) {
//        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
//        if ([baseModel.code integerValue] != 200) {
//            [LLHudTools showWithMessage:baseModel.msg];
//            return ;
//        }
//        self.banks = [LLCashBankModel LLMJParse:baseModel.data];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        BXS_Alert(LLLoadErrorMessage);
//    }];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
