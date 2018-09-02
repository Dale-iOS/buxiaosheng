//
//  LZOutOrderDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZOutOrderDetailBatchNumberModel;
@class LZOutOrderDetailBatchNumberListModel;

@interface LZOutOrderDetailBatchNumberModel : NSObject
@property (nonatomic,copy) NSString *totalA;
@property (nonatomic,copy) NSString *value;
@end

@interface LZOutOrderDetailBatchNumberListModel : NSObject
@property (nonatomic,copy) NSArray <LZOutOrderDetailBatchNumberModel *> *batchNumber;
@property (nonatomic,copy) NSString *itemList;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *unitName;
@end

@interface LZOutOrderDetailModel : NSObject
@property (nonatomic,copy) NSArray <LZOutOrderDetailBatchNumberListModel *> *batchNumberList;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *productColorId;
@property (nonatomic,copy) NSString *productColorName;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *storageType;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *unitName;
@end
