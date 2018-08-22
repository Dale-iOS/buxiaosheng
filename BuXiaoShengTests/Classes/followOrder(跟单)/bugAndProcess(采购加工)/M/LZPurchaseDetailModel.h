//
//  LZPurchaseDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZPurchaseDetailItemListModel;
@class LZPurchaseBottomListModel;
@interface LZPurchaseDetailModel : NSObject
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *contactName;
@property(nonatomic,copy)NSString *factoryName;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSArray <LZPurchaseDetailItemListModel*> *itemList;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *productId;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *storageType;
@property(nonatomic,copy)NSString *tel;
@property(nonatomic,copy)NSString *unitName;
@end

@interface LZPurchaseDetailItemListModel : NSObject
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productColorName;
@property(nonatomic,copy)NSArray <LZPurchaseBottomListModel*> *bottomList;
@end

@interface LZPurchaseBottomListModel : NSObject
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorName;
@property(nonatomic,copy)NSString *total;

@end
