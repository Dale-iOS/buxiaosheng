//
//  LZPurchaseReceivingListDetailProductModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseReceivingListDetailProductModel.h"

@implementation LZPurchaseReceivingListDetailProductModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"colorList":[LZPurchaseReceivingListDetailProductColorListModel class]};
}
@end

@implementation LZPurchaseReceivingListDetailProductColorListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bottomList":[LZPurchaseReceivingListDetailProductBottomListtModel class],
             @"valList":[LZPurchaseReceivingListDetailProductValListModel class]
             };
}
@end

@implementation LZPurchaseReceivingListDetailProductBottomListtModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"productColorNameA": @"productColorName"};
}
@end

@implementation LZPurchaseReceivingListDetailProductValListModel

@end
