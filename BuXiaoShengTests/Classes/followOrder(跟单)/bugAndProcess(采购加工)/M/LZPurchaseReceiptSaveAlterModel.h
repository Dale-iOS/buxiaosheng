//
//  LZPurchaseReceiptSaveAlterModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZPurchaseReceiptSaveAlterItemListModel;

@interface LZPurchaseReceiptSaveAlterItemListModel :NSObject
@property (nonatomic,copy) NSString *value;//细码值
@property (nonatomic,copy) NSString *total;//条数
@end


@interface LZPurchaseReceiptSaveAlterModel : NSObject
@property (nonatomic,copy) NSArray<LZPurchaseReceiptSaveAlterItemListModel *> *itemList;
@property (nonatomic,copy) NSString *productId;//品名id
@property (nonatomic,copy) NSString *productColorId;//品名颜色id
@property (nonatomic,copy) NSString *number;//需求量
@property (nonatomic,copy) NSString *unitName;//单位名称
@property (nonatomic,copy) NSString *name;//供货商名称
@property (nonatomic,copy) NSString *color;//供货商颜色
@property (nonatomic,copy) NSString *unitId;//单位id
@property (nonatomic,copy) NSString *batchNumber;//批号
@property (nonatomic,copy) NSString *shelves;//货架
@property (nonatomic,copy) NSString *price;//单价
@property (nonatomic,copy) NSString *buyNum;//采购数量
@property (nonatomic,copy) NSString *houseNum;//入库数量
@property (nonatomic,copy) NSString *settlementNum;//结算数量
@property (nonatomic,copy) NSString *receivableAmount;//本单应收金额
@end
