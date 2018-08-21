//
//  LZPurchaseReceiptDetailCellModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZPurchaseReceiptDetailCellBottomList;
@class LZPurchaseReceiptDetailCellItemList;

@interface LZPurchaseReceiptDetailCellModel : NSObject
@property (nonatomic,copy) NSString *batchNumber;//批号
@property (nonatomic,copy) NSArray <LZPurchaseReceiptDetailCellBottomList*> *bottomList;//底布列表
@property (nonatomic,copy) NSString *buyNum;//采购数量
@property (nonatomic,copy) NSString *buyOrderItemId;//itemID
@property (nonatomic,copy) NSString *color;//供应商 颜色
@property (nonatomic,copy) NSString *houseNum;//入库数量
@property (nonatomic,copy) NSString *houseUnitName;//产品单位名称
@property (nonatomic,copy) NSArray <LZPurchaseReceiptDetailCellItemList*> *itemList;//细码信息
@property (nonatomic,copy) NSString *name;//供应商 品名
@property (nonatomic,copy) NSString *number;//需求数量
@property (nonatomic,copy) NSString *price;//单价
@property (nonatomic,copy) NSString *productColorId;//产品颜色id
@property (nonatomic,copy) NSString *productColorName;//产品颜色名称
@property (nonatomic,copy) NSString *productId;//产品id
@property (nonatomic,copy) NSString *productName;//产品名称
@property (nonatomic,copy) NSString *receivableAmount;//应收金额
@property (nonatomic,copy) NSString *settlementNum;//结算数量
@property (nonatomic,copy) NSString *shelves;//货架
@property (nonatomic,copy) NSString *storageType;//入库类型
@property (nonatomic,copy) NSString *unitName;//结算单位
@end


@interface LZPurchaseReceiptDetailCellBottomList : NSObject
@property (nonatomic,copy) NSString *number;//数量
@property (nonatomic,copy) NSString *productColorName;//颜色名称
@property (nonatomic,copy) NSString *productName;//品名
@property (nonatomic,copy) NSString *total;//条数
@end


@interface LZPurchaseReceiptDetailCellItemList : NSObject
@property (nonatomic,copy) NSString *total;//条数
@property (nonatomic,copy) NSString *valId;//细码id
@property (nonatomic,copy) NSString *value;//细码值
@end
