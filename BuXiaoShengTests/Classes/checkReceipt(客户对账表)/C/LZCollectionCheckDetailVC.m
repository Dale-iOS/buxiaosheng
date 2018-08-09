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
#import "LZNetHelp.h"
#import "LZTypeTopModel.h"

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
    
    
    NSString *jsonTop = @"{\"code\":200,\"data\":{\"arrearsPrice\":400.0,\"createTime\":20180627154517,\"customerMobile\":\"1372981603\",\"customerName\":\"越南\",\"depositPrice\":50.0,\"drawerName\":\"周鹏\",\"labelNumber\":90.0,\"netreceiptsPrice\":0.0,\"orderDetailId\":85,\"orderNo\":\"AAAB-20180627-0011\",\"outNumber\":90.0,\"receivablePrice\":450.0,\"remark\":\"备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注备注这是一条很长的备注\",\"settleNumber\":90.0,\"total\":5,\"trimPrice\":0.0,\"type\":0},\"msg\":\"请求成功\"}";
    
    
    NSString *jsonBottom = @"{\"code\":200,\"data\":[{\"colorList\":[{\"price\":5.0,\"productColorName\":\"#粉\",\"total\":2,\"unitName\":\"米\",\"valList\":[{\"total\":1,\"value\":20.0},{\"total\":1,\"value\":10.0}]}],\"productName\":\"天丝剪花\",\"totalNumber\":30.0},{\"colorList\":[{\"price\":5.0,\"productColorName\":\"#白\",\"total\":2,\"unitName\":\"米\",\"valList\":[{\"total\":1,\"value\":20.0},{\"total\":1,\"value\":10.0}]},{\"price\":5.0,\"productColorName\":\"#杏\",\"total\":1,\"unitName\":\"米\",\"valList\":[{\"total\":1,\"value\":30.0}]}],\"productName\":\"36D天丝\",\"totalNumber\":60.0}],\"msg\":\"请求成功\"}";
    
    NSDictionary *jsonDic = [LZNetHelp dictionaryWithJsonString:jsonBottom];
    
    NSDictionary *jsonTopDic = [LZNetHelp dictionaryWithJsonString:jsonTop];
    
    
    LZTBView *xdTbView = [[LZTBView alloc] initWithFrame:self.view.bounds];
    
    NSMutableArray *models = [[LZTypeProductModel setOriginSource:jsonDic[@"data"]] mutableCopy];
    
    LZTypeTopModel *topModels = [LZTypeTopModel createModelWithOriginSource:jsonTopDic[@"data"]];
    
    [xdTbView setUIOriginSource:models andTopSource:topModels];
    
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
