//
//  LZSpendingModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

@class LZSpendingDetailModel;
#import <Foundation/Foundation.h>

@interface LZSpendingModel : NSObject

@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *bankName;
@property(nonatomic,copy)NSString *costsubjectName;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *tallyTime;
@end


@interface LZSpendingDetailModel : NSObject

@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *approverName;
@property(nonatomic,copy)NSString *bankId;
@property(nonatomic,copy)NSString *bankName;
@property(nonatomic,copy)NSString *costsubjectName;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *tallyTime;
@end
