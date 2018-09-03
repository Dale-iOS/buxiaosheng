//
//  LZPurchasingInfoDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZPurchasingInfoDetailItemListModel;
@class LZPurchasingInfoDetaiLogisticslModel;

@interface LZPurchasingInfoDetailItemListModel : NSObject
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *productColorId;
@property (nonatomic,copy) NSString *productColorName;
@end

@interface LZPurchasingInfoDetailModel : NSObject
@property (nonatomic,copy) NSString *buyId;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSArray <LZPurchasingInfoDetailItemListModel *> *itemList;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *successTime;
@property (nonatomic,copy) NSString *totalNumber;
@end

@interface LZPurchasingInfoDetaiLogisticslModel : NSObject
@property (nonatomic,copy) NSString *arrivalTime;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *remark;
@end
