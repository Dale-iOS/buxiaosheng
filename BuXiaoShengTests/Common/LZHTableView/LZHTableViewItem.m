//
//  LZHTableViewItem.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZHTableViewItem.h"

@implementation LZHTableViewItem

- (id)init
{
    self = [super init];
    if (self) {
        self.canSelected = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
