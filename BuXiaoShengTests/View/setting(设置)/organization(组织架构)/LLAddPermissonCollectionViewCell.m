//
//  LLAddPermissonCollectionViewCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddPermissonCollectionViewCell.h"

@implementation LLAddPermissonCollectionViewCell
{
    UIImageView * _iconImageView;
    UILabel * _titleLable;
    UIButton * _addBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    _iconImageView = [UIImageView new];
    _iconImageView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.height.width.mas_equalTo(49);
    }];
    
    _titleLable = [UILabel new];
    _titleLable.text = @"订单追踪";
    [self.contentView addSubview:_titleLable];
    _titleLable.textColor = [UIColor darkGrayColor];
    _titleLable.font = [UIFont systemFontOfSize:15];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom).offset(5);
        make.centerX.equalTo(_iconImageView);
    }];
    _addBtn = [UIButton new];
    [_iconImageView addSubview:_addBtn];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"add_permisson"] forState:UIControlStateNormal];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView).offset(5);
        make.right.equalTo(_iconImageView).offset(-5);
    }];
}
@end
