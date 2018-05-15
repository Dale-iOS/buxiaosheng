//
//  LLAddPermissonSectionView.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddPermissonSectionView.h"

@implementation LLAddPermissonSectionView

{
    UILabel * _titleLable;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIView * contentView = [UIView new];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        _titleLable = [UILabel new];
        [contentView addSubview:_titleLable];
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.text = @"销售权限";
        _titleLable.textColor = [UIColor darkGrayColor];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15);
            make.centerY.equalTo(contentView);
        }];
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(contentView);
            make.height.mas_equalTo(1);
        }];
        
        
    }
    return self;
}

@end
