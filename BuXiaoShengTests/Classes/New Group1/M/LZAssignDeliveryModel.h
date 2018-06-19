//
//  LZAssignDeliveryModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZAssignDeliveryModel : NSObject
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *customerName;
@property(nonatomic,copy)NSString *delivererName;
@property(nonatomic,copy)NSString *drawerName;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *needTotal;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *orderStatus;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productId;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,assign)BOOL isSelect;//用于判断是否被选中
@end
