//
//  LZStockDemandListDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  备货需求采购详情

#import "LZStockDemandListDetailVC.h"
#import "LZStockDemandListDetailModel.h"

@interface LZStockDemandListDetailVC ()
@property (nonatomic, strong) LZStockDemandListDetailModel *model;
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

//备货需求列表详情
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#
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
        _model = [LZStockDemandListDetailModel LLMJParse:baseModel.data];
        NSLog(@"123");
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
