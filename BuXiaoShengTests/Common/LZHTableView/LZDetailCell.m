//
//  LZDetailCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDetailCell.h"
@interface LZDetailCell()
@end

@implementation LZDetailCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    //顶部线
    self.topLine = [[UIView alloc]init];
    self.topLine.backgroundColor = LZHBackgroundColor;
    [self addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.and.right.equalTo(self);
        make.height.mas_offset(0.5);
    }];
    
    //左边图标
    self.leftIMV = [[UIImageView alloc]init];
    [self addSubview:self.leftIMV];
    [self.leftIMV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.and.height.mas_offset(19);
    }];
    
    //左边文字
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = FONT(14);
    self.titleLabel.textColor = CD_Text33;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIMV.mas_right).offset(10);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
        make.centerY.equalTo(self);
    }];
    
    
     //右边图标
    self.rightArrowImageVIew = [[UIImageView alloc]init];
    self.rightArrowImageVIew.image = IMAGE(@"rightarrow");
    [self addSubview:self.rightArrowImageVIew];
    [self.rightArrowImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.width.mas_offset(8);
        make.height.mas_offset(14);
    }];
    
    //右边文字
    self.hintLabel = [[UILabel alloc]init];
    self.hintLabel.font = FONT(13);
    self.hintLabel.textAlignment = NSTextAlignmentRight;
    self.hintLabel.textColor = CD_Text99;
    self.hintLabel.text = @"查看更多";
    [self addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(70);
        make.height.mas_offset(14);
        make.right.equalTo(self.rightArrowImageVIew.mas_left).offset(-10);
        make.centerY.equalTo(self);
    }];
    
    //底部线
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.backgroundColor = LZHBackgroundColor;
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.and.right.equalTo(self);
        make.height.mas_offset(0.5);
    }];
}

@end
