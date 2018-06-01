//
//  LZOutboundModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutboundModel.h"

@implementation LZOutboundModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList":[LZOutboundItemListModel class],
             };
}
@end

@implementation LZOutboundItemListModel
@end


@implementation LLOutboundlistModel
@end


@implementation LLOutboundRightModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList":[LLOutboundRightDetailModel class],
             };
}
@end
@implementation LLOutboundRightDetailModel


@end
