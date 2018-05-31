//
//  LZOutboundSectionView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutboundSectionView.h"

@implementation LZOutboundSectionView
{
    UIView * _bgView;
    UILabel * _nameLable;//品名
    UILabel * _demandLable;//需求
    UILabel * _colorLable;//颜色
    //UIButton * _foldingBtn;//折叠按钮
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    self.contentView.backgroundColor = [UIColor whiteColor];
    _nameLable = [UILabel new];
    [self.contentView addSubview:_nameLable];
    _nameLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _nameLable.font = [UIFont systemFontOfSize:14];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(_bgView.mas_bottom).offset(10);
    }];
    
    _demandLable = [UILabel new];
    [self.contentView addSubview:_demandLable];
    _demandLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _demandLable.font = [UIFont systemFontOfSize:14];
    [_demandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(_nameLable.mas_bottom).offset(8);
    }];
    
    _colorLable = [UILabel new];
    [self.contentView addSubview:_colorLable];
    _colorLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _colorLable.font = [UIFont systemFontOfSize:14];
    [_colorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.top.equalTo(_demandLable.mas_bottom).offset(8);
    }];
    
    
    
    _foldingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_foldingBtn];
    [_foldingBtn addTarget:self action:@selector(foldingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_foldingBtn setTitle:@"展开    " forState:UIControlStateNormal];
    [_foldingBtn setTitle:@"收起    " forState:UIControlStateSelected];
    _foldingBtn.titleLabel.font = FONT(12);
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateSelected];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_close"] forState:UIControlStateNormal];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_show"] forState:UIControlStateSelected];
    
    [_foldingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView);
        // make.width.mas_equalTo(100);
    }];
    [_foldingBtn layoutIfNeeded];
    _foldingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,  -(_foldingBtn.titleLabel.frame.origin.x), 0, 0);
    
    _foldingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width), 0, -(_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width));
}

-(void)foldingBtnClick {
    if ([self.delegate respondsToSelector:@selector(sectionViewDelegate:)]) {
        [self.delegate sectionViewDelegate:self];
    }
}

- (void)setModel:(LZOutboundItemListModel *)model
{
    _model = model;
    _nameLable.text = [NSString stringWithFormat:@"品名 : %@",_model.productName];
    _demandLable.text = [NSString stringWithFormat:@"需求量 : %@",_model.number];
    _colorLable.text = [NSString stringWithFormat:@"颜色 : %@",_model.productColorName];
}

@end

