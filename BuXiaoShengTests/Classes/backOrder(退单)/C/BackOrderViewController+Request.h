//
//  BackOrderViewController+Request.h
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BackOrderViewController.h"

@class LZBackOrderGroup, LZBackOrderItem;

@interface BackOrderViewController (Request)

//接口名称 仓库列表
- (void)setupWarehouseLists;
//接口名称 付款方式
- (void)setupPayList;
//接口名称 功能用到客户列表
- (void)setupCustomerList;
//接口名称 审批人列表
-(void)setupApproverList;
//新增一条的数据模型
- (LZBackOrderGroup *)createSectionGroupItem;

//添加细码样式的数据模型
- (void)createFineYardsItemWithGroup:(LZBackOrderGroup *)group;
//添加总码样式的模型
- (void)createTotalSizeItemWithGroup:(LZBackOrderGroup *)group;

@end
