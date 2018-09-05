//
//  LLWarehouseDetaiSlideRemakeVc.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLWarehouseSideRigthRowModel;
@protocol LLWarehouseDetaiSlideRemakeVcDelegate<NSObject>
-(void)warehouseDetaiSlideDelegateWithSeletedModel:(LLWarehouseSideRigthRowModel*)model;
@end
#import "BaseViewController.h"
@class LLWarehouseDetailModel;
@interface LLWarehouseDetaiSlideRemakeVc : BaseViewController
@property(nonatomic ,strong)LLWarehouseDetailModel * dictModel;
@property(nonatomic ,weak)id <LLWarehouseDetaiSlideRemakeVcDelegate> delegate;
@end
