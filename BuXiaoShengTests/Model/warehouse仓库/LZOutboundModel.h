//
//  LZOutboundModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LZOutboundItemListModel;
#import <Foundation/Foundation.h>

@interface LZOutboundModel : NSObject
@property (nonatomic,copy) NSString *matter;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,strong) NSArray <LZOutboundItemListModel *> *itemList;
@end

@interface LZOutboundItemListModel:NSObject
@property (nonatomic,copy) NSString *needId;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *productColorId;
@property (nonatomic,copy) NSString *productColorName;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *stock;
@property (nonatomic,copy) NSString *storageType;

@property (nonatomic,strong) NSMutableArray * itemCellData;

@property (nonatomic,assign) BOOL seleted;
@end

@interface LLOutboundlistModel : NSObject
@property (nonatomic,copy) NSString *houseId;
@property (nonatomic,copy) NSString *houseName;
@property (nonatomic,assign) BOOL seleted;
@end

@class LLOutboundRightDetailModel;
@interface LLOutboundRightModel : NSObject
@property (nonatomic,copy) NSString *batcNumber;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *unitName;
@property (nonatomic,copy) NSArray <LLOutboundRightDetailModel*> *itemList;
@property (nonatomic,assign) BOOL seleted;
@end

@interface LLOutboundRightDetailModel : NSObject
@property (nonatomic,copy) NSString *stockId;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *value;

@end
