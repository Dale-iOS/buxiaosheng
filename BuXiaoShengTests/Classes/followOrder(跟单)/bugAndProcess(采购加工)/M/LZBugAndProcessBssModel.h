//
//  LZBugAndProcessBssModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZBugAndProcessBssModel : NSObject
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *customerName;
@property(nonatomic,copy)NSString *factoryName;
@property(nonatomic,copy)NSString *houseNum;
//id是系统关键字 不能这么写
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *initiatorName;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *purchaseType;
@end
