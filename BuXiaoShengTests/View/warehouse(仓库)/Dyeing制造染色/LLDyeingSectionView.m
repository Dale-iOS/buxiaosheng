//
//  LLDyeingSectionView.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLDyeingSectionView.h"

@implementation LLDyeingSectionView
{
    UIView * _bgView;
    UILabel * _goodsLable;//品名
    UILabel * _goodsColorLable;//品名颜色
    UILabel * _productNameLable;//供应商品名
    UILabel * _productColorLable;//供应商颜色
    UILabel * _countLable;//条数
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
    _goodsLable = [UILabel new];
    [self.contentView addSubview:_goodsLable];
    _goodsLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _goodsLable.text = @"本店品名:LF001";
    _goodsLable.font = [UIFont systemFontOfSize:14];
    [_goodsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_bgView.mas_bottom).offset(15);
    }];
    
    _goodsColorLable = [UILabel new];
    [self.contentView addSubview:_goodsColorLable];
    _goodsColorLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _goodsColorLable.text = @"品名颜色:红色";
    _goodsColorLable.font = [UIFont systemFontOfSize:14];
    [_goodsColorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_goodsLable.mas_bottom).offset(15);
    }];
    
    _productNameLable = [UILabel new];
    [self.contentView addSubview:_productNameLable];
    _productNameLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _productNameLable.text = @"供应商品名:001";
    _productNameLable.font = [UIFont systemFontOfSize:14];
    [_productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsLable.mas_right).offset(6);
        make.top.equalTo(_bgView.mas_bottom).offset(15);
    }];
    
    _productColorLable = [UILabel new];
    [self.contentView addSubview:_productColorLable];
    _productColorLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _productColorLable.text = @"供应商颜色:黄色";
    _productColorLable.font = [UIFont systemFontOfSize:14];
    [_productColorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsLable.mas_right).offset(6);
        make.top.equalTo(_productNameLable.mas_bottom).offset(15);
    }];
    
    _countLable = [UILabel new];
    [self.contentView addSubview:_countLable];
    _countLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _countLable.text = @"条数:269";
    _countLable.font = [UIFont systemFontOfSize:14];
    [_countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productNameLable.mas_right).offset(6);
        make.top.equalTo(_bgView.mas_bottom).offset(15);
    }];
    
    _foldingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_foldingBtn];
    [_foldingBtn addTarget:self action:@selector(foldingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_foldingBtn setTitle:@"收起    " forState:UIControlStateNormal];
    [_foldingBtn setTitle:@"展开    " forState:UIControlStateSelected];
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

@end
