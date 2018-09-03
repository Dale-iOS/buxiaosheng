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
@property (nonatomic,assign) BOOL    stockId;
@end
