//
//  LZArrearClientView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户（欠款表）

#import "LZArrearClientView.h"

@interface LZArrearClientView()
@end

@implementation LZArrearClientView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor greenColor];
}

@end
