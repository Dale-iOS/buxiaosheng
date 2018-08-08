//
//  LZCollectionCheckDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZCollectionCheckDetailVC.h"
#import "LZCheckReceiptModel.h"

@interface LZCollectionCheckDetailVC ()
{
    NSString *_orderDetailId;
}
@end

@implementation LZCollectionCheckDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupdetail];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"客户对账单详情"];
}

- (void)setupdetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/order_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        LZCheckReceiptModel *model = [LZCheckReceiptModel LLMJParse:baseModel.data];
        _orderDetailId = model.orderDetailId;
        [self setupdetail1];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)setupdetail1{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderDetailId":_orderDetailId
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/order_product.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
//        self.banks = [LLCashBankModel LLMJParse:baseModel.data];
//        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
