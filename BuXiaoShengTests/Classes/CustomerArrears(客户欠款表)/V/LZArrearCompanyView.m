//
//  LZArrearCompanyView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  厂商（欠款表）

#import "LZArrearCompanyView.h"

@interface LZArrearCompanyView()
@end

@implementation LZArrearCompanyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor yellowColor];
}

@end
