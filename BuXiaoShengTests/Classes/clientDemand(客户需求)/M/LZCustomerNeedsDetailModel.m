//
//  LZCustomerNeedsDetailModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZCustomerNeedsDetailModel.h"

@implementation LZCustomerNeedsDetailModel

@end

@implementation LZCustomerNeedsDetailProductValListModel

@end

@implementation LZCustomerNeedsDetailProductColorListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"valList":[LZCustomerNeedsDetailProductValListModel class]};
}

@end

@implementation LZCustomerNeedsDetailProductModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"colorList":[LZCustomerNeedsDetailProductColorListModel class]};
}

@end

