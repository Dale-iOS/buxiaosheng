//
//  BXSDSModel.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSDSModel.h"

@implementation BXSDSModel
/// 懒加载
-(NSMutableArray<LLOutboundRightModel *> *)boundModelList {
    if (!_boundModelList) {
        _boundModelList = [NSMutableArray array];
    }
    return _boundModelList;
}

@end

@implementation BXSBoundModel

@end

