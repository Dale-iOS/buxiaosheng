//
//  LLWarehouseDetailRemarkVC.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
typedef NS_ENUM(NSInteger, LLWarehouseDetailRemarkFromType) {
    LLWarehouseDetailRemarkFromTypeFenPi,          // 分匹
    LLWarehouseDetailRemarkFromTypeHePi,          // 和匹
    LLWarehouseDetailRemarkFromTypeJKJK,          // 加空减空
     LLWarehouseDetailRemarkFromTypePoSun,          // 破损
};
#import "BaseViewController.h"
@class LLWarehouseSideRigthRowModel;
@class LLWarehouseDetailModel;
@interface LLWarehouseDetailRemarkVC : BaseViewController
@property(nonatomic ,strong)LLWarehouseSideRigthRowModel * model;
@property(nonatomic ,assign)LLWarehouseDetailRemarkFromType fromType;
@property(nonatomic ,strong)LLWarehouseDetailModel * dictModel;
@end
