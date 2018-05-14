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
    //箭头
    UIImageView * _arrowImageView;
    
    UILabel * _nameLable;
    
    ///图标
    UIImageView * _iconImageView;
    
    ///图标里面的名字
    UILabel * _iconNameLabel;
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
    if (model.deptName.length > 3) {
        _iconNameLabel.text = [model.deptName substringToIndex:3];
    }else{
        _iconNameLabel.text = model.deptName;
    }
    
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

    _iconImageView = [[UIImageView alloc]initWithImage:IMAGE(@"ordericon")];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_arrowImageView.mas_right).offset(12);
        make.centerY.equalTo(self.contentView);
    }];
    
    _iconNameLabel = [UILabel new];
    _iconNameLabel.textAlignment = NSTextAlignmentCenter;
    [_iconImageView addSubview:_iconNameLabel];
    _iconNameLabel.font = [UIFont systemFontOfSize:15];
    _iconNameLabel.textColor = [UIColor whiteColor];
    [_iconNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_iconImageView).offset(0);
        make.centerY.equalTo(_iconImageView);
        make.centerX.equalTo(_iconImageView);
    }];
    
    _nameLable = [UILabel new];
    [self.contentView addSubview:_nameLable];
    _nameLable.font = [UIFont systemFontOfSize:15];
    _nameLable.textColor = [UIColor darkGrayColor];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(12);
        make.centerY.equalTo(self.contentView);
    }];
}

-(void)sectionViewClick {
    self.model.sectionClick = !self.model.sectionClick;
    self.block(self);
}

@end
