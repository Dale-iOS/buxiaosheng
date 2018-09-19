//
//  LZStockDemandListDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZStockDemandListDetailItemListModel;
@class LZStockDemandListDetailItemListBottomListModel;

@interface LZStockDemandListDetailItemListBottomListModel : NSObject
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorName;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *total;
@end

@interface LZStockDemandListDetailItemListModel : NSObject
@property(nonatomic,copy)NSArray <LZStockDemandListDetailItemListBottomListModel *> *bottomList;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productColorName;
@end

@interface LZStockDemandListDetailModel : NSObject
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *contactName;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *factoryName;
@property(nonatomic,copy)NSString *initiatorName;
@property(nonatomic,copy)NSArray <LZStockDemandListDetailItemListModel *> *itemList;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *purchaserName;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *tel;

@end
