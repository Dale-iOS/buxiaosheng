//
//  LZPaymentOrderListModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZPaymentOrderListModel : NSObject
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *bankName;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *factoryName;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *type;

@end
