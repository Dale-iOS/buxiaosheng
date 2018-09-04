//
//  LZPurchaseReceiptDataModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZPurchaseReceiptDataItemListModel;
@class LZPurchaseReceiptDataItemListBottomListModel;

@interface LZPurchaseReceiptDataItemListBottomListModel : NSObject
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *productColorName;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *total;
@end

@interface LZPurchaseReceiptDataItemListModel : NSObject
@property (nonatomic,copy) NSArray<LZPurchaseReceiptDataItemListBottomListModel *> *bottomList;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *productColorId;
@property (nonatomic,copy) NSString *productColorName;
@end

@interface LZPurchaseReceiptDataModel : NSObject
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *buyProductId;
@property (nonatomic,copy) NSString *contactName;
@property (nonatomic,copy) NSString *factoryName;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *imgs;
@property (nonatomic,copy) NSString *initiatorId;
@property (nonatomic,copy) NSArray<LZPurchaseReceiptDataItemListModel *> *itemList;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *storageType;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *unitName;
//@property (nonatomic,copy) NSArray<LZSaveOrderProductList *> *productList;
@end
