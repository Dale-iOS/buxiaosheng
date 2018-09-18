//
//  LZStockDemandListModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZStockDemandListModel : NSObject
@property (nonatomic, copy)NSString *buyId;
@property (nonatomic, copy)NSString *createTime;
@property (nonatomic, copy)NSString *factoryName;
@property (nonatomic, copy)NSString *houseNum;
@property (nonatomic, copy)NSString *initiatorName;
@property (nonatomic, copy)NSString *number;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *purchaseType;
@property (nonatomic, copy)NSString *status;
@end
