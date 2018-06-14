//
//  LZBankDetailModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBankDetailModel.h"

@implementation LZBankDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[LZBankDetailListModel class]};
}
@end

@implementation LZBankDetailListModel
@end
