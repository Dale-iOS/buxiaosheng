//
//  LZPurchaseReceiptVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购收货页面

#import "LZPurchaseReceiptVC.h"

@interface LZPurchaseReceiptVC ()

@end

@implementation LZPurchaseReceiptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"采购收货"];
}

#pragma mark ---- 网络请求 ----
- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.bugId};
    [BXSHttp requestGETWithAppURL:@"documentary/not_handle_detail.do" param:param success:^(id response) {
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
