//
//  LLAuditMangerModel.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAuditMangerModel.h"

@implementation LLAuditMangerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"itemList" : @"LLAuditMangerItemModel"
             };
}
    
@end



@implementation LLAuditMangerItemModel

@end
