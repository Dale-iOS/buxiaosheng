//
//  LLOutbounceSeletedHeaderView.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/1.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLOutbounceSeletedHeaderView.h"

@implementation LLOutbounceSeletedHeaderView
{
    UILabel * _detalLable;
    
    UIImageView * _arrowImageView;
}
-(void)setModel:(LLOutboundRightModel *)model {
    _model = model;
    _detalLable.text = [NSString stringWithFormat:@"%@  %@条/%@%@",model.batcNumber,model.total,model.number,model.unitName];
    _model.seleted ? (_arrowImageView.transform = CGAffineTransformMakeRotation(M_PI)) :(_arrowImageView.transform = CGAffineTransformIdentity);

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
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dyeing_close"]];
     addGestureRecognizer(_arrowImageView, arrowImageViewClick)
     addGestureRecognizer(self, arrowImageViewClick)
    [self addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-3);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(21);
        make.height.mas_equalTo(12);
    }];
    
    _detalLable = [UILabel new];
    _detalLable.numberOfLines = 0;
    [self addSubview:_detalLable];
    _detalLable.textColor = [UIColor darkGrayColor];
    _detalLable.font = [UIFont systemFontOfSize:14];
    [_detalLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.centerY.equalTo(self);
        make.right.equalTo(_arrowImageView.mas_left);
    }];
}

-(void)arrowImageViewClick {
    self.block(self);
}
@end
