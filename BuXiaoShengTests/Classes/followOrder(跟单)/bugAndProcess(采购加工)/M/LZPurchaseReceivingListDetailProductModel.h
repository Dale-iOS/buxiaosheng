//
//  LZPurchaseReceivingListDetailProductModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZPurchaseReceivingListDetailProductColorListModel;
@class LZPurchaseReceivingListDetailProductBottomListtModel;
@class LZPurchaseReceivingListDetailProductValListModel;

@interface LZPurchaseReceivingListDetailProductValListModel : NSObject
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *value;
@end

@interface LZPurchaseReceivingListDetailProductBottomListtModel : NSObject
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorNameA;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *total;
@end

@interface LZPurchaseReceivingListDetailProductColorListModel : NSObject
@property(nonatomic,copy)NSArray <LZPurchaseReceivingListDetailProductBottomListtModel*> *bottomList;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *productColorName;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *unitName;
@property(nonatomic,copy)NSArray <LZPurchaseReceivingListDetailProductValListModel*> *valList;
@end

@interface LZPurchaseReceivingListDetailProductModel : NSObject
@property(nonatomic,copy)NSString *buyNum;
@property(nonatomic,copy)NSArray <LZPurchaseReceivingListDetailProductColorListModel*> *colorList;
@property(nonatomic,copy)NSString *houseNum;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *receivableAmount;
@property(nonatomic,copy)NSString *settlementNum;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *totalNumber;
@end
