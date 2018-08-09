//
//  LZCollectionCheckDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户对账单详情

#import "LZCollectionCheckDetailVC.h"
#import "LZCollectionCheckDetailMsgModel.h"
#import "LZCollectionCheckDetailProductModel.h"
#import "LZTypeProductModel.h"
#import "LZTBView.h"

@interface LZCollectionCheckDetailVC ()
{
    NSString *_orderDetailId;
}
@property (nonatomic, strong) LZCollectionCheckDetailMsgModel *msgModel;
@property (nonatomic, strong) LZCollectionCheckDetailProductModel *productModel;

@end

@implementation LZCollectionCheckDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getMsgData];
    
    
    NSDictionary *jsonDic = @{
                              @"data":@[@{
                                            @"colorList":@{
                                                    @"price":@"33",
                                                    @"productColorName":@"浅红色",
                                                    @"total":@"9999",
                                                    @"unitName":@"米",
                                                    @"valList":@[@{@"total":@"9",@"value":@"50 89 65 59 102 50 89 65 59 102 50 89 65 59 102 50 89 65 59 102 50 89 65 59 102 50 89 65 59 102"},
                                                                 @{@"total":@"99",@"value":@"50 89 65 59 102 50 89 65 59 102"},
                                                                 @{@"total":@"999",@"value":@"50 89 65 59 102 50 89 65 59 102 50 89 65 59 102"}],
                                                    },
                                            @"productName":@"品名1",
                                            @"totalNumber":@"9999"},
                                        @{
                                            @"colorList":@{
                                                    @"price":@"33",
                                                    @"productColorName":@"绿色",
                                                    @"total":@"9999",
                                                    @"unitName":@"米",
                                                    @"valList":@[@{@"total":@"9999",@"value":@"50 89 65 59 102 50 89 65 59 102"}],
                                                    },
                                            @"productName":@"品名2",
                                            @"totalNumber":@"9999"},
                                        @{
                                            @"colorList":@{
                                                    @"price":@"33",
                                                    @"productColorName":@"黄色",
                                                    @"total":@"9999",
                                                    @"unitName":@"米",
                                                    @"valList":@[@{@"total":@"9999",@"value":@"50 89 65 59 102"},@{@"total":@"9999",@"value":@"50 89 65 59 102 "},@{@"total":@"9999",@"value":@"50 89 65 59 102 "},@{@"total":@"9999",@"value":@"50 89 65 59 102 50 89 65 59 102 50 89 65 59 102 50 89 65 59 102 50 89 65 59 102"}],
                                                    },
                                            @"productName":@"品名2",
                                            @"totalNumber":@"9999"}
                                        ]
                              };
    
    
    
    LZTBView *xdTbView = [[LZTBView alloc] initWithFrame:self.view.bounds];
    
    NSMutableArray *models = [[LZTypeProductModel setOriginSource:jsonDic[@"data"]] mutableCopy];
    
    [xdTbView setUIOriginSource:models];
    
    [self.view addSubview:xdTbView];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"客户对账单详情"];
}

#pragma mark ----- 网络请求 -----
- (void)getMsgData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/order_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.msgModel = [LZCollectionCheckDetailMsgModel LLMJParse:baseModel.data];
        _orderDetailId = self.msgModel.orderDetailId;
        [self getProductData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)getProductData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderDetailId":_orderDetailId
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/order_product.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.productModel = [LZCollectionCheckDetailProductModel LLMJParse:baseModel.data];
        NSLog(@"123");
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
