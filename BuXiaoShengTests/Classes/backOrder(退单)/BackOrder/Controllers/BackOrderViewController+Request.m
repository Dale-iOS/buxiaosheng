//
//  BackOrderViewController+Request.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BackOrderViewController+Request.h"
#import "NSObject+YYModel.h"
#import "LZBackOrderGroup.h"
#import "LZBackOrderItem.h"

@implementation BackOrderViewController (Request)

#pragma mark --- 网络请求 ---
//接口名称 功能用到客户列表
- (void)setupCustomerList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"customer/customer_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSArray *customerListAry = baseModel.data;
        self.customerNameAry = [NSMutableArray array];
        self.customerIdAry = [NSMutableArray array];
        self.customerMobileAry = [NSMutableArray array];
        for (int i = 0 ; i <customerListAry.count; i++) {
            [self.customerNameAry addObject:customerListAry[i][@"name"]];
            [self.customerIdAry addObject:customerListAry[i][@"id"]];
            [self.customerMobileAry addObject:customerListAry[i][@"mobile"]];
        }
        self.nameArray = [self.customerNameAry copy];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 仓库列表
- (void)setupWarehouseLists
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestPOSTWithAppURL:@"house/list.do" param:param success:^(id response) {
        
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        self.warehouseNameAry = [NSMutableArray array];
        self.warehouseIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [self.warehouseIdAry addObject:tempAry[i][@"id"]];
            [self.warehouseNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 付款方式
- (void)setupPayList {
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        self.payNameAry = [NSMutableArray array];
        self.payIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [self.payIdAry addObject:tempAry[i][@"id"]];
            [self.payNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

-(void)setupApproverList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"approver/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.approverList = baseModel.data;
        self.approverNameAry = [NSMutableArray array];
        self.approverIdAry = [NSMutableArray array];
        for (int i = 0; i <self.approverList.count; i++) {
            [self.approverIdAry addObject:self.approverList[i][@"approverId"]];
            [self.approverNameAry addObject:self.approverList[i][@"memberName"]];
        }
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (LZBackOrderGroup *)createSectionGroupItem {
    NSString *plistString = [[NSBundle mainBundle] pathForResource:@"BackOrder" ofType:@"plist"];
    NSArray *groupDictArray = [NSArray arrayWithContentsOfFile:plistString];
    LZBackOrderGroup *group = [LZBackOrderGroup modelWithDictionary:groupDictArray[1]];
    return  group;
}

//添加细码样式
- (void)createFineYardsItemWithGroup:(LZBackOrderGroup *)group {
    if (group.items.count == 13) {
        [group.items removeObjectAtIndex:3];
        [group.items removeObjectAtIndex:3];
        for (int i = 5; i < 10; i++) {
            LZBackOrderItem *item = [group.items objectAtIndex:i];
            item.detailTitle = @"0";
        }
    }
    //本身之前已经选择细码
    if (group.items.count == 12) {
        return;
    }
    NSDictionary *dic = @{@"textTitle":@"细码 (总条数: 0 )",
                          @"detailTitle":@" ",
                          @"placeHolder":@"",
                          @"detailColor":[UIColor blackColor],
                          @"clickType":@(0),
                          @"cellType":@(2),
                          @"canInput":@(NO),
                          @"showArrow":@(NO),
                          @"mandatoryOption":@(NO),
                          @"numericKeyboard":@(NO)
                          };
    LZBackOrderItem *tmpItem = [LZBackOrderItem modelWithDictionary:dic];
    [group.items insertObject:tmpItem atIndex:3];
}

//添加总码样式的模型
- (void)createTotalSizeItemWithGroup:(LZBackOrderGroup *)group {
    if (group.items.count == 12) {
        [group.items removeObjectAtIndex:3];
        for (int i = 5; i < 10; i++) {
            LZBackOrderItem *item = [group.items objectAtIndex:i];
            item.detailTitle = @"0";
        }
    }
    //本身之前已经选择总码
    if (group.items.count == 13) {
        return;
    }
    NSDictionary *dic = @{@"textTitle":@"总数量",
                          @"detailTitle":@"",
                          @"placeHolder":@"请输入总数量",
                          @"detailColor":@"0",
                          @"clickType":@(0),
                          @"cellType":@(0),
                          @"canInput":@(YES),
                          @"showArrow":@(NO),
                          @"mandatoryOption":@(NO),
                          @"numericKeyboard":@(YES)
                          };
    LZBackOrderItem *tmpItem = [LZBackOrderItem modelWithDictionary:dic];;
    [group.items insertObject:tmpItem atIndex:3];
    
    NSDictionary *dic1 = @{@"textTitle":@"条数",
                          @"detailTitle":@"",
                          @"placeHolder":@"请输入条数",
                          @"detailColor":@"0",
                          @"clickType":@(0),
                          @"cellType":@(0),
                          @"canInput":@(YES),
                          @"showArrow":@(NO),
                          @"mandatoryOption":@(NO),
                          @"numericKeyboard":@(YES)
                          };
    LZBackOrderItem *tmpItem1 = [LZBackOrderItem modelWithDictionary:dic1];;
    [group.items insertObject:tmpItem1 atIndex:4];
}

@end
