//
//  LZFindCodeModel.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/6/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZFindCodeModel.h"

@implementation LZFindCodeModel

+ (id)initModelTitle:(NSString *)title code:(NSString *)code {
    LZFindCodeModel *model = [LZFindCodeModel new];
    model.title = title;
    model.code = code;
    return model;
}
@end
