//
//  LZTypeTopModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZTypeTopModel.h"
#import <UIKit/UIKit.h>

@implementation LZTypeTopModel

+ (LZTypeTopModel *)createModelWithOriginSource:(NSDictionary *)origin {
    LZTypeTopModel *model = [[LZTypeTopModel alloc] init];
    [model setValuesForKeysWithDictionary:origin];
    float width = [UIScreen mainScreen].bounds.size.width - 120;
    model.remakeHeight = [model.remark boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size.height + 1;
    if (model.remakeHeight < 30) {
        model.remakeHeight = 30;
    }
    return model;
}

@end
