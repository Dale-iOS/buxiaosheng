//
//  LLProcessSectionView.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLProcessSectionView.h"

@implementation LLProcessSectionView
{
    UILabel * _goodsNameLable;//品名
    UILabel * _demandLable;//需求
    UIButton * _foldingBtn;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    UIView * containerView = [UIView new];
    [self.contentView addSubview:containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(54);
    }];
    _goodsNameLable = [UILabel new];
    [containerView addSubview:_goodsNameLable];
    _goodsNameLable.text = @"品名:  LF001";
    _goodsNameLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _goodsNameLable.font = [UIFont systemFontOfSize:15];
    [_goodsNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView).offset(15);
        make.centerY.equalTo(containerView);
    }];
    
    _demandLable = [UILabel new];
    [containerView addSubview:_demandLable];
    _demandLable.text = @"需求量:  6899755";
    _demandLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _demandLable.font = [UIFont systemFontOfSize:15];
    [_demandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNameLable.mas_right).offset(15);
        make.centerY.equalTo(containerView);
    }];
    
    _foldingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [containerView addSubview:_foldingBtn];
    [_foldingBtn addTarget:self action:@selector(foldingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_foldingBtn setTitle:@"展开    " forState:UIControlStateNormal];
    [_foldingBtn setTitle:@"收起    " forState:UIControlStateSelected];
    _foldingBtn.titleLabel.font = FONT(12);
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateSelected];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_close"] forState:UIControlStateNormal];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_show"] forState:UIControlStateSelected];
    
    [_foldingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-15);
        make.centerY.equalTo(containerView);
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

@end
