//
//  LZCollectionCheckDetailProductModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZInventoryListValListModel;
@class LZInventoryListColorListModel;

@interface LZCollectionCheckDetailProductModel : NSObject
@property (nonatomic,copy)NSArray <LZInventoryListColorListModel *> *colorList;
@property (nonatomic,copy)NSString *productName;
@property (nonatomic,copy)NSString *totalNumber;
@end

@interface LZInventoryListColorListModel : NSObject
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *productColorName;
@property (nonatomic,copy)NSString *total;
@property (nonatomic,copy)NSString *unitName;
@property (nonatomic,copy)NSArray <LZInventoryListValListModel *> *valList;
@end

@interface LZInventoryListValListModel : NSObject
@property (nonatomic,copy)NSString *total;
@property (nonatomic,copy)NSString *value;
@end
