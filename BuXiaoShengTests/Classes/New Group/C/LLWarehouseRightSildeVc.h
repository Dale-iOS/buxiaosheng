//
//  LLWarehouseRightSildeVc.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"
@class LZInventoryDetailModel;
@interface LLWarehouseRightSildeVc : BaseViewController
@property(nonatomic ,strong)LZInventoryDetailModel * model;
@property(nonatomic ,copy)NSString * houseId;
@property(nonatomic ,weak)BaseNavigationController * baseNavVc;
@end
