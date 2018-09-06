//
//  LLBankDetailListChildVc.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"

@interface LLBankDetailListChildVc : BaseViewController
@property(nonatomic ,assign)NSInteger dateType;
@property(nonatomic ,copy)NSString * startDate;
@property(nonatomic ,copy)NSString * endDate;
@property(nonatomic ,copy)NSString * bankId;
@property(nonatomic ,copy)NSString * incomeId;
@end
