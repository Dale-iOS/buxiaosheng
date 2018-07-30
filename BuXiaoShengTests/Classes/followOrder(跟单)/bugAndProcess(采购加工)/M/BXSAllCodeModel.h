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


@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productColorName;

/// 应该付的钱
@property (strong,nonatomic)NSString *shouldPay;

// J
@property (copy,nonatomic)NSMutableArray *dataArray;
//
@property (assign,nonatomic)BOOL isFindCode;

// 细码的数组
@property (copy,nonatomic)NSMutableArray<LZFindCodeModel *> *findCodeArray;


@end
