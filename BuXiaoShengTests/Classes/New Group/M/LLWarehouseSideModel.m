//
//  LLWarehouseSideModel.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseSideModel.h"

@implementation LLWarehouseSideModel

@end
@implementation LLWarehouseSideRigthSectionModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList":[LLWarehouseSideRigthRowModel class],
             };
}
@end
@implementation LLWarehouseSideRigthRowModel

@end

@implementation LLWarehouseDetailModel

@end
