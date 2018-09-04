//
//  LLWarehouseSideModel.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LLWarehouseSideRigthRowModel;
@interface LLWarehouseSideModel : NSObject
@property (nonatomic,copy) NSString *colorId;
@property (nonatomic,copy) NSString *colorName;
@property (nonatomic,copy) NSString *houseId;
@property (nonatomic,assign) BOOL    seleted;
@end

@interface LLWarehouseSideRigthSectionModel:NSObject
@property (nonatomic,copy) NSString *batcNumber;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *unitName;
@property (nonatomic,assign) BOOL    seleted;
@property (nonatomic,copy) NSArray <LLWarehouseSideRigthRowModel*>*    itemList;
@end

@interface LLWarehouseSideRigthRowModel:NSObject
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *isReduce;
@property (nonatomic,assign) BOOL    seleted;
@property (nonatomic,copy) NSString*    stockId;
@end

@interface LLWarehouseDetailModel:NSObject
@property (nonatomic,copy) NSString *batchNumber;
@property (nonatomic,copy) NSString *breadth;
@property (nonatomic,copy) NSString *component;
@property (nonatomic,copy) NSString *costAmount;
@property (nonatomic,copy) NSString*    costUnitPrice;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *houseName;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *productColorId;
@property (nonatomic,copy) NSString *productColorName;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *shelvesNumber;
@property (nonatomic,copy) NSString *stockId;
@property (nonatomic,copy) NSString *storageType;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *unitName;
@property (nonatomic,copy) NSString *weight;

@end
