//
//  LLAuditMangerSectionModel.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAuditMangerSectionView.h"
#import "LLAuditMangerModel.h"
@implementation LLAuditMangerSectionView
{
    UIImageView * _arrowImageView;
    UILabel * _nameLable;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setModel:(LLAuditMangerModel *)model {
    _model = model;
    _nameLable.text = model.deptName;
    [UIView animateWithDuration:0.25 animations:^{
        if (_model.sectionClick) {
            _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }else {
            _arrowImageView.transform = CGAffineTransformIdentity;
        }
    }];
   
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        addGestureRecognizer(self.contentView, sectionViewClick)
    }
    return self;
}

-(void)setupUI {
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"auditManger_arrow"]];
    [self.contentView addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset((15));
        make.centerY.equalTo(self.contentView);
    }];
    
    _nameLable = [UILabel new];
    [self.contentView addSubview:_nameLable];
    _nameLable.font = [UIFont systemFontOfSize:15];
    _nameLable.textColor = [UIColor darkGrayColor];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_arrowImageView.mas_right).offset(12);
        make.centerY.equalTo(self.contentView);
    }];
}

-(void)sectionViewClick {
    self.model.sectionClick = !self.model.sectionClick;
    self.block(self);
}

@end
