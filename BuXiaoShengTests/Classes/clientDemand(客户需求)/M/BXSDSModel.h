//
//  BXSDSModel.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//底色的模型

#import <Foundation/Foundation.h>

@class LLOutboundRightModel;
@interface BXSDSModel : NSObject

@property (nonatomic,copy) NSString *productColorId;
@property (nonatomic,copy) NSString *productColorName;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;


@property (nonatomic,copy) NSString *stock;
@property (nonatomic,copy) NSString *storageType;

@property (nonatomic,copy) NSString *ckTotal;
@property (nonatomic,copy) NSString *total;

@property (strong,nonatomic)NSMutableArray<LLOutboundRightModel *> *boundModelList;


@property (assign,nonatomic) CGFloat cellHeight;

@end



@interface BXSBoundModel : NSObject
/// 库存
@property (nonatomic,copy) NSString *allCount;
/// 出库
@property (nonatomic,copy) NSString *outCount;
/// 条数
@property (nonatomic,copy) NSString *unitCount;
/// 仓库
@property (nonatomic,copy) NSString *id;

@end
