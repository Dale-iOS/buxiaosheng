//
//  LZOrderTrackingModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZOrderTrackingModel : NSObject

@property(nonatomic,copy)NSString *buyStatus;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *customerName;
@property(nonatomic,copy)NSString *drawerName;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *needTotal;
@property(nonatomic,copy)NSString *orderStatus;

@end
