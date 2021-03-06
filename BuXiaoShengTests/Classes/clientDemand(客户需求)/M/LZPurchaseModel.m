//
//  LZPurchaseModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseModel.h"

@implementation LZPurchaseModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZPurchaseItemListModel class]};
}
@end

@implementation LZPurchaseItemListModel

/// 懒加载
- (NSMutableArray *)dsArray {
    if (!_dsArray) {
        _dsArray = [NSMutableArray array];
    }
    return _dsArray;
}
@end
