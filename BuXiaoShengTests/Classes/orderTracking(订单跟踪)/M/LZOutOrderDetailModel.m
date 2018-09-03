//
//  LZOutOrderDetailModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutOrderDetailModel.h"

@implementation LZOutOrderDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"batchNumberList":[LZOutOrderDetailBatchNumberListModel class]};
}
@end

@implementation LZOutOrderDetailBatchNumberListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"batchNumber":[LZOutOrderDetailBatchNumberModel class]};
}
@end

@implementation LZOutOrderDetailBatchNumberModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"totalA": @"total"};
}
@end
