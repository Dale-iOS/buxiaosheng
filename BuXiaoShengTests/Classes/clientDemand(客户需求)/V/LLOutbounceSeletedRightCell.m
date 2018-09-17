//
//  LLOutbounceSeletedRightCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/1.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLOutbounceSeletedRightCell.h"

@implementation LLOutbounceSeletedRightCell

-(void)setModel:(LLOutboundRightDetailModel *)model {
    _model = model;
    
    //假如细码值有小数，就只保留一位小数
    if ([model.value containsString:@"."]) {
        _totalCount.text = [NSString stringWithFormat:@"%.1f",model.value.doubleValue];
    }else{
        _totalCount.text = model.value;
    }

    model.seleted ? (self.contentView.layer.borderColor = LZAppBlueColor.CGColor) : (self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor);
    model.seleted ? (_totalCount.textColor = LZAppBlueColor) : (_totalCount.textColor= [UIColor lightGrayColor]);
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 6;
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = LZAppBlueColor.CGColor;
        _totalCount =[ UILabel new];
        [self.contentView addSubview:_totalCount];
        _totalCount.textColor = [UIColor lightGrayColor];
        _totalCount.font = [UIFont systemFontOfSize:15];
        _totalCount.textAlignment = NSTextAlignmentCenter;
        [_totalCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}
@end
