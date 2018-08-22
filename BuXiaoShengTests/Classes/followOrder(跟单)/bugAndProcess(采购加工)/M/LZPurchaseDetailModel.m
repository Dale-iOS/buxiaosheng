//
//  LZPurchaseDetailModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseDetailModel.h"

#import "LZPurchaseDetailModel.h"

@implementation LZPurchaseDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZPurchaseDetailItemListModel class]};
}
@end


@implementation LZPurchaseDetailItemListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bottomList":[LZPurchaseBottomListModel class]};
}


@end

@implementation LZPurchaseBottomListModel

@end


