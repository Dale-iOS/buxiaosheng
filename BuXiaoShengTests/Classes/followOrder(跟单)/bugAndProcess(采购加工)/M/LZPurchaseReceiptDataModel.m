//
//  LZPurchaseReceiptDataModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseReceiptDataModel.h"

@implementation LZPurchaseReceiptDataModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZPurchaseReceiptDataItemListModel class]};
}
@end

@implementation LZPurchaseReceiptDataItemListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bottomList":[LZPurchaseReceiptDataItemListBottomListModel class]};
}
@end

@implementation LZPurchaseReceiptDataItemListBottomListModel

@end
