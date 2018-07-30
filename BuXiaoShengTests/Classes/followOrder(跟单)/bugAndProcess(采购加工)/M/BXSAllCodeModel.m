//
//  BXSAllCodeModel.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSAllCodeModel.h"

@implementation BXSAllCodeModel


/// 懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray ) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/// 懒加载

- (NSMutableArray *)findCodeArray {
    if (!_findCodeArray) {
        _findCodeArray = [NSMutableArray array];
    }
    return _findCodeArray;
}
@end
