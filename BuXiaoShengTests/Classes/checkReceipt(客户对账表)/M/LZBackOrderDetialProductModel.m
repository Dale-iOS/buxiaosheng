//
//  LZBackOrderDetialProductModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBackOrderDetialProductModel.h"

@implementation LZBackOrderDetialProductValListModel
@end

@implementation LZBackOrderDetialProductColorListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"valList":[LZBackOrderDetialProductValListModel class]};
}
@end

@implementation LZBackOrderDetialProductModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"colorList":[LZBackOrderDetialProductColorListModel class]};
}
@end
