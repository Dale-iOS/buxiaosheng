//
//  LZBackOrderSaveModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZBackOrderSaveItemList :NSObject
@property (nonatomic,copy) NSString *value;//总码：总数量   细码：1
@property (nonatomic,copy) NSString *total;//总码：条数     细码：值
@end

@interface LZBackOrderSaveModel : NSObject
@property (nonatomic, copy) NSArray<LZBackOrderSaveItemList *> *itemList;
@property (nonatomic, copy) NSString *productId;//产品id
@property (nonatomic, copy) NSString *productColorId;//颜色id
@property (nonatomic, copy) NSString *batchNumber;//批号
@property (nonatomic, copy) NSString *shelves;//货架
@property (nonatomic, copy) NSString *price;//单价
@property (nonatomic, copy) NSString *houseNum;//入库数量
@property (nonatomic, copy) NSString *labelNum;//标签数量
@property (nonatomic, copy) NSString *settlementNum;//结算数量
@property (nonatomic, copy) NSString *refundAmount;//本单退款金额
@end
