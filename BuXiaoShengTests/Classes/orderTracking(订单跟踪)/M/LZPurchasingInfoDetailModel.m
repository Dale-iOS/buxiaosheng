//
//  LZPurchasingInfoDetailModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchasingInfoDetailModel.h"

@implementation LZPurchasingInfoDetailItemListModel

@end


@implementation LZPurchasingInfoDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZPurchasingInfoDetailItemListModel class]};
}
@end


@implementation LZPurchasingInfoDetaiLogisticslModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}
@end
