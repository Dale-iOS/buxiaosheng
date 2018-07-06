//
//  LZChooseBankTypeCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseBankTypeCell.h"

@implementation LZChooseBankTypeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 29)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        self.titleLabel.textColor = CD_Text99;
        self.titleLabel.layer.cornerRadius = 5.0f;
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.font = FONT(12);
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setModel:(LZChooseBankTypeModel *)model
{
    _model = model;
    self.titleLabel.text = model.name;
    self.id = model.id;
    
    if (_model.isSelect) {
        self.titleLabel.backgroundColor = LZAppBlueColor;
        self.titleLabel.textColor = [UIColor whiteColor];
    }else{
        self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        self.titleLabel.textColor = CD_Text99;
    }
}

@end
