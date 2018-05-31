//
//  LZInventoryModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZInventoryModel.h"

@implementation LZInventoryModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList":[LZInventoryListModel class],
             };
}
@end

@implementation LZInventoryListModel
@end
