//
//  LZStockDemandListDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  备货需求采购详情

#import "LZStockDemandListDetailVC.h"

@interface LZStockDemandListDetailVC ()

@end

@implementation LZStockDemandListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getDetailData];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"备货需求采购详情"];
}

#pragma mark --- 网络请求 ---
- (void)getDetailData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.buyId
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/stock_need_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
