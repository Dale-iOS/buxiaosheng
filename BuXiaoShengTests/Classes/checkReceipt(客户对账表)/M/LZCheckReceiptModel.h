//
//  LZCheckReceiptModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZCheckReceiptModel : NSObject
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *bankName;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *operatorName;
@property(nonatomic,copy)NSString *orderDetailId;
@end
