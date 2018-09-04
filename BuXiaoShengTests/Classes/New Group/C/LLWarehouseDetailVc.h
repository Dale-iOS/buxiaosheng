//
//  LLWarehouseDetailVcViewController.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
typedef NS_ENUM(NSInteger, LLWarehouseDetailVcFromType) {
    LLWarehouseDetailVcFromTypeDetail,          // 查看详情
    LLWarehouseDetailVcFromTypePrint,     // 打印
};

#import "BaseViewController.h"
@class LLWarehouseSideRigthRowModel;
@interface LLWarehouseDetailVc : BaseViewController
@property(nonatomic ,strong)LLWarehouseSideRigthRowModel * model;
@property(nonatomic ,assign)LLWarehouseDetailVcFromType formType;
@end
