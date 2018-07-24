//
//  LZBackOrderGroup.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZBackOrderGroup.h"
#import "LZBackOrderItem.h"

@implementation LZBackOrderGroup

- (instancetype)initWithFlod:(BOOL)flod items:(NSArray *)items {
    if ([super init]) {
        _fold = flod;
        NSMutableArray *tempArr = @[].mutableCopy;
        for (NSDictionary *dic in items) {
            LZBackOrderItem *item = [[LZBackOrderItem alloc] init];
            [item setValuesForKeysWithDictionary:dic];
            [tempArr addObject:item];
        }
        _items = tempArr;
    }
    return self;
}

- (NSMutableArray *)itemStrings {
    if (_itemStrings == nil) {
        _itemStrings = @[].mutableCopy;
    }
    return _itemStrings;
}

+ (instancetype)groupWithFlod:(BOOL)flod items:(NSArray *)items {
    return [[self alloc] initWithFlod:flod items:items];
}

@end
