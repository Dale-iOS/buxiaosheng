//
//  LZBackOrderGroup.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBackOrderGroup.h"
#import "LZBackOrderItem.h"
#import "NSObject+YYModel.h"

@implementation LZBackOrderGroup

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"items":[LZBackOrderItem class]};
}

@end
