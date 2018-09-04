//
//  BXSAllCodeModel.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseModel.h"

#import "LZFindCodeModel.h"
@interface BXSAllCodeModel : BaseModel

// 需求量
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productColorName;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *buyProductId;
// 单位
@property(nonatomic,copy)NSString *houseUnitName;

@property(nonatomic,copy)NSString *buyOrderItemId;

/// 应该付的钱
@property (strong,nonatomic)NSString *shouldPay;

// J
@property (copy,nonatomic)NSMutableArray *dataArray;
//
@property (assign,nonatomic)BOOL isFindCode;

// 细码的数组
@property (copy,nonatomic)NSMutableArray<LZFindCodeModel *> *findCodeArray;


@end
