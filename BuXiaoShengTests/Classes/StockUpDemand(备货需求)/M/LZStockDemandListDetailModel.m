//
//  LZStockDemandListDetailModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZStockDemandListDetailModel.h"


@implementation LZStockDemandListDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZStockDemandListDetailItemListModel class]};
}
@end

@implementation LZStockDemandListDetailItemListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bottomList":[LZStockDemandListDetailItemListBottomListModel class]};
}
@end

@implementation LZStockDemandListDetailItemListBottomListModel

@end
