//
//  salesDemandModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class productListModel;


#import <Foundation/Foundation.h>

@interface salesDemandModel : NSObject
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productColorId;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *titleInfo;
@property (nonatomic, copy) NSString *colorInfo;
@property (nonatomic, copy) NSString *lineInfo;
@property (nonatomic, copy) NSString *numberInfo;
@property (nonatomic, copy) NSString *priceInfo;
@end

@class LLSalesColorListModel;
@interface productListModel : NSObject
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shearPrice;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *unitName;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic,copy) NSString  * number;
@property (nonatomic,strong) LLSalesColorListModel  * colorModel;
@property (nonatomic,copy) NSString  * productColorId;
@property (nonatomic,copy) NSString  * price;
@end

@interface LLSalesColorListModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *productId;
@end

@class LZSaveSaleModel;
@interface LZSaveSaleModel : NSObject
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productColorId;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *price;
@end
