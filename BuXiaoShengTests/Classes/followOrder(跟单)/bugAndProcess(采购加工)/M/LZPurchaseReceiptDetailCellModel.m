//
//  LZPurchaseReceiptDetailCellModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseReceiptDetailCellModel.h"

@implementation LZPurchaseReceiptDetailCellModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bottomList":[LZPurchaseReceiptDetailCellBottomList class],
             @"itemList":[LZPurchaseReceiptDetailCellItemList class]
             
             };
}

@end

@implementation LZPurchaseReceiptDetailCellBottomList
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZPurchaseReceiptDetailCellItemList class]};
}
@end

@implementation LZPurchaseReceiptDetailCellItemList

@end
