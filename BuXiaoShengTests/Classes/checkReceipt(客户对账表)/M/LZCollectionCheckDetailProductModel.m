//
//  LZCollectionCheckDetailProductModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZCollectionCheckDetailProductModel.h"

@implementation LZCollectionCheckDetailProductModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"colorList":[LZInventoryListColorListModel class]};
}
@end

@implementation LZInventoryListColorListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"valList":[LZInventoryListValListModel class]};
}
@end

@implementation LZInventoryListValListModel

@end
