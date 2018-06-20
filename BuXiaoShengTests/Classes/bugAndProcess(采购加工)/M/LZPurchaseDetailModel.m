//
//  LZPurchaseDetailModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseDetailModel.h"

@implementation LZPurchaseDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZPurchaseDetailItemListModel class]};
}
@end


@implementation LZPurchaseDetailItemListModel

@end
