//
//  ChooseLablesCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ChooseLablesCell.h"

@implementation ChooseLablesCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, APPWidth *0.14, 29)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.layer.cornerRadius = 10.0f;
        self.titleLabel.text = @"999999";
        self.titleLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
