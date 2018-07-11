//
//  LZClientModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZClientModel.h"

@implementation LZClientModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"itemList" : [LZAuditMangerItemModel class],
             };
}
@end

@implementation LZAuditMangerItemModel

@end
