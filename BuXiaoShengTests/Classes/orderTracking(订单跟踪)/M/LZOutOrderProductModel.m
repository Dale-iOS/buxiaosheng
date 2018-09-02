//
//  LZOutOrderProductModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutOrderProductModel.h"

@implementation LZOutOrderProductModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"colorList":[LZOutOrderProductColorListModel class]};
}
@end


@implementation LZOutOrderProductColorListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"valList":[LZOutOrderProductValListModel class]};
}
@end


@implementation LZOutOrderProductValListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"totalA": @"total"};
}
@end
